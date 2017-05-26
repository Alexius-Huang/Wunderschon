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

  describe 'enum' do
    it 'should have status enum' do
      expect(Order.statuses.keys).to include('pending')
      expect(Order.statuses.keys).to include('cancelled')
      expect(Order.statuses.keys).to include('paid')
      expect(Order.statuses.keys).to include('rejected')
      expect(Order.statuses.keys).to include('delivered')
    end
  end

  describe 'aasm' do
    shared_examples 'transitions' do |action, params|
      it "should able to #{action} from #{params[:from]} to #{params[:to]}" do
        order = create(:order, params[:from], :with_one_item)
        expect(order.send(:"#{params[:from]}?")).to be_truthy
        expect(order.send(:"may_#{action}?")).to be_truthy
        order.send(:"#{action}!")
        expect(order.send(:"#{params[:to]}?")).to be_truthy
      end
    end

    it_should_behave_like 'transitions', :pay,     from: :pending,   to: :paid
    it_should_behave_like 'transitions', :deliver, from: :paid,      to: :delivered
    it_should_behave_like 'transitions', :cancel,  from: :pending,   to: :cancelled
    it_should_behave_like 'transitions', :reject,  from: :delivered, to: :rejected 
  end
end
