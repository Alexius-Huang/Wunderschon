require 'rails_helper'

RSpec.describe Order, type: :model do
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
    # TODO Issue #9
    # describe 'aasm states' do
    #   Order.statuses.each_keys do |status|
    #     describe ".#{status_order_count}"
    #   end
    # end
  end

  describe 'instance methods' do
    describe '.total_price' do
      it 'should get total price of the order'
    end

    describe '.add_item' do
      context 'basic utility' do
        it 'should have new order item if Product isn\'t in the order item list'
        it 'should add quantity of order item if product has already in the order'
        it 'can add second parameter which specifies the quantity to add in the order'
      end

      context 'invalid' do
        it 'should not pass in other than Product class instance'
        it 'should not pass in not persisted Product record'
        it 'should not pass in "unavailable" Product'
        it 'should not add items with negative or zero value of quantity'
      end
    end

    describe '.delete_item' do
      context 'basic utility' do
        it 'should delete one item at a time when specifying the item in the order list'
        it 'can add second parameter which specifies the quantity to delete in the order'
        it 'can pass in "unavailable" Product if appeared in order list'
      end

      context 'invalid' do
        it 'should not pass in other than Product class instance'
        it 'should not pass in not persisted Product record'
        it 'should not delete items which doesn\'t appear in the order item list'
        it 'should not delete items with negative or zero value of quantity'
        it 'should not delete items with quantity larger than the order item\'s quantity'
      end
    end
  end
end
