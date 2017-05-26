require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'association' do
    it { is_expected.to belong_to(:category) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_numericality_of(:price).only_integer.is_greater_than_or_equal_to(0) }
  end
end
