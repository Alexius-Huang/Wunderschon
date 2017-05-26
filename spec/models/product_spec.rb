require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'association' do
    it { should belong_to(:category) }
  end
end
