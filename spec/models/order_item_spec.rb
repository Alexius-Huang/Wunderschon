# frozen_string_literal: true
require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe 'association' do
    it { is_expected.to belong_to(:order) }
    it { is_expected.to belong_to(:product) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_numericality_of(:quantity).only_integer.is_greater_than(0) }
    it { is_expected.to validate_numericality_of(:price).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe 'instance methods' do
    let!(:order_item) { create(:order_item) }
    describe '.total_price' do
      it 'should get total price of the order item' do
        expect(order_item.total_price).to eq (order_item.price * order_item.quantity)
      end
    end

    shared_examples 'pass in negative or zero value' do |method|
      it "should not update quantity in method: .#{method}" do
        error_msg = 'should pass in quantity larger than zero'
        expect { order_item.send(method, rand(-1..0)) }.to raise_exception(ActiveRecord::Rollback, error_msg)
      end
    end

    shared_examples 'update quantity when record deleted' do |method|
      before { order_item.increase!(rand(1..10)) if order_item.quantity == 1 }
      it "should not update when using .#{method}" do
        order_item.reload
        order_item.destroy!
        error_msg = 'record already being deleted'
        expect(order_item.deleted?).to be_truthy
        expect { order_item.send(method, rand(1..(order_item.quantity - 1))) }.to raise_exception(ActiveRecord::Rollback, error_msg)
      end
    end

    describe '.increase' do
      context 'basic utility' do
        let!(:quantity) { order_item.quantity }
        it 'should increase the quantity of the order default as one without saved' do
          order_item.increase
          expect(order_item.quantity).to eq quantity.next
          order_item.reload
          expect(order_item.quantity).to eq quantity
        end

        it 'should increase the quantity of the order if specified quantity without saved' do
          increased_quantity = rand 1..10
          order_item.increase increased_quantity
          expect(order_item.quantity).to eq (quantity + increased_quantity)
          order_item.reload
          expect(order_item.quantity).to eq quantity
        end
      end

      context 'invalid' do
        it_should_behave_like 'pass in negative or zero value', :increase
      end
    end

    describe '.increase!' do
      context 'basic utility' do
        let!(:quantity) { order_item.quantity }
        it 'should increase the quantity of the order default as one' do
          order_item.increase!
          expect(order_item.quantity).to eq quantity.next
          order_item.reload
          expect(order_item.quantity).to eq quantity.next
        end

        it 'should increase the quantity of the order if specified quantity' do
          increased_quantity = rand 1..10
          order_item.increase! increased_quantity
          expect(order_item.quantity).to eq (quantity + increased_quantity)
          order_item.reload
          expect(order_item.quantity).to eq (quantity + increased_quantity)
        end
      end

      context 'invalid' do
        it_should_behave_like 'pass in negative or zero value', :increase!
        it_should_behave_like 'update quantity when record deleted', :increase!
      end
    end

    describe '.decrease' do
      before { order_item.increase!(rand(1..10)) if order_item.quantity == 1 }
      context 'basic utility' do
        let!(:quantity) { order_item.quantity }
        it 'should decrease the quantity of the order default as one without save' do
          order_item.decrease
          expect(order_item.quantity).to eq (quantity - 1)
          order_item.reload
          expect(order_item.quantity).to eq quantity
        end

        it 'should decrease the quantity of the order if specified quantity without save' do
          decrease_quantity = rand(1..(quantity - 1))
          order_item.decrease decrease_quantity
          expect(order_item.quantity).to eq (quantity - decrease_quantity)
          order_item.reload
          expect(order_item.quantity).to eq quantity
        end

        it 'should not automatically being destroyed when quantity is zero' do
          order_item.decrease quantity
          expect(order_item.quantity).to be_zero
          order_item.reload
          expect(order_item.quantity).to eq quantity
        end
      end

      context 'invalid' do
        it_should_behave_like 'pass in negative or zero value', :decrease
      end
    end

    describe '.decrease!' do
      before { order_item.increase!(rand(1..10)) if order_item.quantity == 1 }
      context 'basic utility' do
        let!(:quantity) { order_item.quantity }
        it 'should decrease the quantity of the order default as one' do
          order_item.decrease!
          expect(order_item.quantity).to eq (quantity - 1)
          order_item.reload
          expect(order_item.quantity).to eq (quantity - 1)
        end

        it 'should decrease the quantity of the order if specified quantity' do
          decrease_quantity = rand(1..(quantity - 1))
          order_item.decrease! decrease_quantity
          expect(order_item.quantity).to eq (quantity - decrease_quantity)
          order_item.reload
          expect(order_item.quantity).to eq (quantity - decrease_quantity)
        end

        it 'should automatically being destroyed when quantity is zero' do
          order_item.decrease! quantity
          expect(order_item.deleted?).to be_truthy
        end
      end

      context 'invalid' do
        let!(:quantity) { order_item.quantity }
        it_should_behave_like 'pass in negative or zero value', :decrease!
        it_should_behave_like 'update quantity when record deleted', :decrease!
        it 'should not pass in quantity larger than the OrderItem quantity' do
          expect { order_item.decrease!(quantity.next) }.to raise_exception(ActiveRecord::RecordInvalid, /Quantity must be greater than 0/)
        end
      end
    end
  end
end
