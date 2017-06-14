# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CartItem, type: :model do
  let(:product)   { create(:product) }
  let(:quantity)  { rand(3..10) }
  let(:cart_item) { described_class.send :new, product: product, quantity: quantity }
  describe 'initialize' do
    it 'initialize method should be private' do
      expect(CartItem.private_methods).to include :new
    end

    it 'can initialize CartItem instance with product' do
      cart_item = described_class.send :new, product: product
      expect(cart_item).to be_kind_of CartItem
      expect(cart_item.product).to be_kind_of Product
      expect(cart_item.quantity).to eq 1
      expect(cart_item.price).to eq cart_item.product.price
    end

    it 'can initailize CartItem instance with product and quantity' do
      expect(cart_item).to be_kind_of CartItem
      expect(cart_item.product).to be_kind_of Product
      expect(cart_item.quantity).to eq quantity
      expect(cart_item.price).to eq cart_item.product.price
    end
  end

  describe 'instance methods' do
    describe '.info' do
      let(:cart_item_info) { cart_item.info }
      it 'should get the info of the cart item' do
        expect(cart_item_info[:product]).to     be_kind_of Hash
        expect(cart_item_info[:quantity]).to    be_kind_of Integer
        expect(cart_item_info[:price]).to       be_kind_of Integer
        expect(cart_item_info[:total_price]).to be_kind_of Integer
      end
    end

    describe '.total_price' do
      it 'should get the total price of the cart_item' do
        expect(cart_item.total_price).to eq (cart_item.price * cart_item.quantity)
      end
    end

    shared_examples 'pass in negative or zero value of quantity' do |method|
      it 'should raise ArgumentError' do
        error_msg = "#{method} quantity should be larger than zero"
        expect { cart_item.send(method, rand(-1..0)) }.to raise_error(ArgumentError, error_msg)
      end
    end

    describe '.increase' do
      context 'basic utility' do
        it 'should increase the quantity of the cart_item default as one' do
          cart_item.increase
          expect(cart_item.quantity).to eq quantity.next
        end

        it 'can pass in paramter which represent the quantity to increase' do
          increase_quantity = rand(2..10)
          cart_item.increase increase_quantity
          expect(cart_item.quantity).to eq (quantity + increase_quantity)
        end
      end

      context 'invalid' do
        it_should_behave_like 'pass in negative or zero value of quantity', :increase
      end
    end

    describe '.decrease' do
      context 'basic utility' do
        it 'should decrease the quantity of the cart_item default as one' do
          cart_item.decrease
          expect(cart_item.quantity).to eq (quantity - 1)
        end

        it 'can pass in parameter which represent the quantity to decrease' do
          decrease_quantity = rand(2..(cart_item.quantity - 1))
          cart_item.decrease decrease_quantity
          expect(cart_item.quantity).to eq (quantity - decrease_quantity)
        end
      end

      context 'invalid' do
        it_should_behave_like 'pass in negative or zero value of quantity', :decrease
        it 'should not pass in larger value than the quantity of the cart_item itself' do
          error_msg = 'Should not decrease value over than cart_item quantity itself'
          expect { cart_item.decrease(cart_item.quantity.next) }.to raise_error(ArgumentError, error_msg)
        end
      end
    end
  end
end
