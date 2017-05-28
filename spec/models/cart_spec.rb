# frozon_string_literal: true
require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe 'initialize' do
    it 'can initialize new cart without any params'
    it 'can initialize an array of product with quantity hash'
  end

  describe 'class methods' do
    describe '.from_hash' do
      it 'can initialize new cart with cart hash'
    end
  end

  describe 'instance methods' do
    describe '.total_price' do
      it 'should get the total price of the cart'
    end

    describe '.product_exist?' do
      it 'should returns true if product exist from cart items of cart'
    end

    describe '.get_cart_item_by_product' do
      it 'should get the product if product exist in cart items of cart'
      it 'should return nil if product isn\'t exist in cart items of cart'
    end

    describe '.add_item' do
      context 'basic utility' do
        it 'should add the quantity default as one if product already in cart item list'
        it 'should create new cart item of the cart if product no exist originally'
        it 'can pass second parameter represent the quantity of the cart item to add'
      end

      context 'invalid' do
        it 'should not pass in negative or zero value of quantity'
        it 'should not add "unavailable" product'
        it 'should not add "unavailable" product when product is still in the cart item'
      end
    end

    describe '.delete_item' do
      context 'basic utility' do
        it 'should delete the quantity default as one if product already in cart item list'
        it 'can pass second parameter represent the quantity of the cart item to delete'
        it 'can pass in "unavailable" product if exist in cart item list'
      end

      context 'invalid' do
        it 'should not pass in negative or zero value of quantity'
        it 'should not pass in the product which is not in the cart item list'
      end
    end

    describe '.to_hash' do
      it 'should convert the cart details into a hash value'
    end

    describe '.checkout!' do
      context 'basic utility' do
        it 'should create order and order_items from the cart detail and user provided data'
      end

      context 'invalid' do
        it 'should not checkout if the user provided data is empty or invalid'
        it 'should not checkout if the cart is empty'
      end
    end
  end
end
