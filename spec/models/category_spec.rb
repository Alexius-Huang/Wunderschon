require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'association' do
    it { is_expected.to have_many(:products) }
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:title)       }
    it { is_expected.to validate_presence_of(:description) }
  end
end
