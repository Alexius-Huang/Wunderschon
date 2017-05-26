require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'association' do
    it { is_expected.to have_many(:order_items) }
  end
end
