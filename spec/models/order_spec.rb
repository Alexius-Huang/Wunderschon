# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Order, type: :model do
  let!(:order) { create(:order, :with_order_items) }
  describe 'factory' do
    it 'should create a valid record' do
      order = build(:order)
      expect(order.valid?).to be_truthy
      expect(order.save).to be_truthy
    end

    describe 'trait' do
      context 'with_one_item' do
        it 'should create exactly one OrderItem record associated to the Order record' do
          order = create(:order, :with_one_item)
          expect(order.order_items.count).to be 1
        end
      end

      context 'with_order_items' do
        it 'should create at least one OrderItem records associated to the Order record' do
          order = create(:order, :with_order_items)
          expect(order.order_items.any?).to be_truthy 
        end
      end
    end
  end

  describe 'association' do
    it { is_expected.to have_many(:order_items) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:tel) }
  end

  describe 'enum' do
    it 'should have status enum' do
      expect(Order.statuses.keys).to include('pending')
      expect(Order.statuses.keys).to include('cancelled')
      expect(Order.statuses.keys).to include('paid')
      expect(Order.statuses.keys).to include('rejected')
      expect(Order.statuses.keys).to include('delivered')
    end
  end

  describe 'aasm' do
    shared_examples 'transitions' do |action, params|
      it "should able to #{action} from #{params[:from]} to #{params[:to]}" do
        order = create(:order, params[:from], :with_one_item)
        expect(order.send(:"#{params[:from]}?")).to be_truthy
        expect(order.send(:"may_#{action}?")).to be_truthy
        order.send(:"#{action}!")
        expect(order.send(:"#{params[:to]}?")).to be_truthy
      end
    end

    it_should_behave_like 'transitions', :pay,     from: :pending,   to: :paid
    it_should_behave_like 'transitions', :deliver, from: :paid,      to: :delivered
    it_should_behave_like 'transitions', :cancel,  from: :pending,   to: :cancelled
    it_should_behave_like 'transitions', :reject,  from: :delivered, to: :rejected
  end

  describe 'class methods' do
    # TODO: Issue #9
    # describe 'aasm states' do
    #   Order.statuses.each_keys do |status|
    #     describe ".#{status_order_count}"
    #   end
    # end
  end

  describe 'instance methods' do
    describe '.total_price' do
      it 'should get total price of the order' do
        expect(order.total_price).to eq order.order_items.map(&:total_price).sum
      end
    end

    describe '.product_exist?' do
      it 'should return true if product exist in the order item list' do
        product = order.order_items.sample.product
        expect(order.product_exist?(product)).to be_truthy
      end

      it 'should return false if product is not in the order item list' do
        product = create(:product)
        expect(order.product_exist?(product)).to be_falsey
      end
    end

    describe '.get_order_item_by_product' do
      it 'should return nil if not found' do
        product = create(:product)
        expect(order.get_order_item_by_product(product)).to be_nil
      end

      it 'should return the order_item of the order via Product' do
        product = order.order_items.sample.product
        order_item = order.order_items.where(product: product).first
        expect(order.get_order_item_by_product(product)).to eq order_item
      end
    end

    shared_examples 'pass in negative or zero quantity' do |method|
      it "should not #{method.to_s.split('_').join("\s")} when quantity is smaller than one" do
        product = order.order_items.sample.product
        error_msg = 'should pass in quantity larger than zero'
        expect { order.send(method, product, rand(-1..0)) }.to raise_exception(ActiveRecord::Rollback, error_msg)
      end
    end

    describe '.add_item' do
      context 'basic utility' do
        let!(:order_items_count) { order.order_items.count }
        it 'should have new order item if Product isn\'t in the order item list' do
          product = create(:product)
          order.add_item product
          order_item = order.get_order_item_by_product(product)
          expect(order.order_items.count).to eq order_items_count.next
          expect(order.product_exist?(product)).to be_truthy
          expect(order_item.quantity).to eq 1
        end

        it 'should add quantity of order item if product has already in the order' do
          product = order.order_items.sample.product
          order_item = order.get_order_item_by_product(product)
          product_order_item_quantity = order_item.quantity
          order.add_item product
          order_item.reload
          expect(order.order_items.count).to eq order_items_count
          expect(order.product_exist?(product)).to be_truthy
          expect(order_item.quantity).to be product_order_item_quantity.next
        end

        it 'can add second parameter which specifies the quantity to add in the order' do
          product = rand(1..2) == 1 ? create(:product) : order.order_items.sample.product
          increase_quantity = rand(1..10)
          quantity = order.product_exist?(product) ? order.get_order_item_by_product(product).quantity : 0
          order.add_item(product, increase_quantity)
          expect(order.get_order_item_by_product(product).quantity).to eq (quantity + increase_quantity)
        end
      end

      context 'invalid' do
        shared_examples 'unavailable product' do |spec_title|
          it spec_title do
            error_msg = "#{unavailable_product.title} is unavailable"
            expect { order.add_item unavailable_product }.to raise_exception(ActiveRecord::Rollback, error_msg)
          end
        end

        let!(:unavailable_product) { create(:product, :unavailable) }
        it_should_behave_like 'unavailable product', 'should not pass in "unavailable" Product'
        it_should_behave_like 'unavailable product', 'should not add unavailable product when appeared in the order item list'
        it_should_behave_like 'pass in negative or zero quantity', :add_item
      end
    end

    describe '.delete_item' do
      context 'basic utility' do
        let!(:product_sample) { order.order_items.sample.product }
        let!(:order_item) do
          order_item = order.get_order_item_by_product product_sample
          order.add_item(product_sample, rand(1..10)) if order_item.quantity == 1
          order_item.reload
        end
        let!(:quantity) { order_item.quantity }

        it 'should delete one item at a time when specifying the item in the order list' do
          order.delete_item product_sample
          order_item.reload
          expect(order_item.quantity).to eq (quantity - 1)
        end

        it 'can add second parameter which specifies the quantity to delete in the order' do
          decrease_quantity = rand(2..quantity) - 1
          order.delete_item(product_sample, decrease_quantity)
          order_item.reload
          expect(order_item.quantity).to eq (quantity - decrease_quantity)
        end

        it 'can pass in "unavailable" Product if exist in order list' do
          product_sample.close!
          expect(product_sample.unavailable?).to be_truthy
          order.delete_item product_sample
          order_item.reload
          expect(order_item.quantity).to eq (quantity - 1)
        end
      end

      context 'invalid' do
        it_should_behave_like 'pass in negative or zero quantity', :delete_item
        it 'should not delete items which doesn\'t exist in the order item list' do
          product = create(:product)
          error_msg = "#{product.title} is not in order item list"
          expect(order.product_exist?(product)).to be_falsey
          expect { order.delete_item(product) }.to raise_exception(ActiveRecord::Rollback, error_msg)
        end

        it 'should not delete items with quantity larger than the order item\'s quantity' do
          order_item = order.order_items.sample
          product = order_item.product
          quantity = order_item.quantity
          expect { order.delete_item(product, quantity.next) }.to raise_exception(ActiveRecord::RecordInvalid, /數量 需要大於 0/)
        end
      end
    end
  end
end
