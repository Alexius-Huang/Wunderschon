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
    describe '.total_price' do
      it 'should get total price of the order item'
    end

    describe '.increase' do
      context 'basic utility' do
        it 'should increase the quantity of the order default as one'
        it 'should increase the quantity of the order if specified quantity'
      end

      context 'invalid' do
        it 'should not pass in negative or zero value of quantity'
      end
    end

    describe '.decrease' do
      context 'basic utility' do
        it 'should decrease the quantity of the order default as one'
        it 'should decrease the quantity of the order if specified quantity'
        it 'should automatically being destroyed when quantity is zero'
      end

      context 'invalid' do
        it 'should not pass in negative or zero value of quantity'
        it 'should not pass in quantity larger than the OrderItem quantity'
      end
    end
  end
end
