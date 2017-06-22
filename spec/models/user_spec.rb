require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user)   { create(:user) }

  describe 'factory' do
    it 'should create an user' do
      expect{user}.to change{User.count}.by(1)
    end
  end
end
