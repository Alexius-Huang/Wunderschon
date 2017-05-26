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
end
