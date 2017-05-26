require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'association' do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to have_many(:order_details) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_numericality_of(:price).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe 'enum' do
    it 'should have status enum' do
      expect(described_class.statuses.keys).to include("available")
      expect(described_class.statuses.keys).to include("unavailable")
    end
  end

  describe 'aasm' do
    let!(:product)          { create(:product) }
    let(:available_product) { create(:product, :available) }
    describe 'initial state' do
      it 'initial state should be unavailable' do
        expect(product.unavailable?).to be_truthy
      end
    end
    
    describe 'transitions' do
      it 'should able to open product under any condition' do
        expect(product.unavailable?).to be_truthy
        expect(product.may_open?).to be_truthy
        product.open!
        expect(product.available?).to be_truthy
      end

      it 'should able to close product under any condition' do
        expect(available_product.available?).to be_truthy
        expect(available_product.may_close?).to be_truthy
        available_product.close!
        expect(available_product.unavailable?).to be_truthy
      end
    end
  end
end
