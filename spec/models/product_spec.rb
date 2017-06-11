# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'factory' do
    it 'should create a valid record' do
      product = build(:product)
      expect(product.valid?).to be_truthy
      expect(product.category).not_to be_nil
      expect(product.save).to be_truthy
    end

    describe 'traits' do
      context 'statuses' do
        shared_examples 'status trait' do |type|
          it "should create record with status \"#{type}\" using trait :#{type}" do
            expect(create(:product, type).status).to eq type.to_s
          end
        end

        it_should_behave_like 'status trait', :available
        it_should_behave_like 'status trait', :unavailable
      end
    end
  end

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
      expect(described_class.statuses.keys).to include('available')
      expect(described_class.statuses.keys).to include('unavailable')
    end
  end

  describe 'aasm' do
    let!(:product)            { create(:product) }
    let(:unavailable_product) { create(:product, :unavailable) }
    describe 'transitions' do
      it 'should able to open product under any condition' do
        expect(unavailable_product.unavailable?).to be_truthy
        expect(unavailable_product.may_open?).to be_truthy
        unavailable_product.open!
        expect(unavailable_product.available?).to be_truthy
      end

      it 'should able to close product under any condition' do
        expect(product.available?).to be_truthy
        expect(product.may_close?).to be_truthy
        product.close!
        expect(product.unavailable?).to be_truthy
      end
    end
  end

  describe 'class methods' do
    # TODO: Issue #10
    # describe '.history_earn' do
    # end
  end

  describe 'instance methods' do
    # TODO: Issue #10
    # describe '.history_earn' do
    # end

    # TODO: Issue #10
    # describe '.sold_quantity' do
    # end
  end
end
