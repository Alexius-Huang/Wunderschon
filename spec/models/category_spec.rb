# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { create(:category) }
  describe 'factory' do
    it 'should create a valid record' do
      category = build(:category)
      expect(category.valid?).to be_truthy
      expect(category.save).to be_truthy
    end

    describe 'traits' do
      context 'with_products' do
        let!(:category) { create(:category, :with_products) }
        it 'creates category with at least one products' do
          expect(category.products.any?).to be_truthy
        end
      end
    end
  end

  describe 'association' do
    it { is_expected.to have_many(:products) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:title)       }
    it { is_expected.to validate_presence_of(:description) }
  end

  describe 'instance methods' do
    describe '.info' do
      let(:category_info) { category.info }
      it 'should get the info of the category' do
        expect(category_info[:id]).to          be_kind_of Integer
        expect(category_info[:title]).to       be_kind_of String
        expect(category_info[:description]).to be_kind_of String
      end
    end
  end
end
