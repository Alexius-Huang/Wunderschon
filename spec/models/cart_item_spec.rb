# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CartItem, type: :model do
  describe 'initialize' do
    it 'can initialize CartItem instance with product'
    it 'can initailize CartItem instance with product and quantity'
  end

  describe 'instance methods' do
    describe '.total_price' do
      it 'should get the total price of the cart_item'
    end

    describe '.product' do
      it 'should get the product object from of the cart_item'
    end

    describe '.increase' do
      context 'basic utility' do
        it 'should increase the quantity of the cart_item default as one'
        it 'can pass in paramter which represent the quantity to increase'
      end

      context 'invalid' do
        it 'should not pass in negative or zero value of quantity'
      end
    end

    describe '.decrease' do
      context 'basic utility' do
        it 'should decrease the quantity of the cart_item default as one'
        it 'can pass in parameter which represent the quantity to decrease'
        it 'should automatically delete cart_item from cart if quantity is decreased to zero'
      end

      context 'invalid' do
        it 'should not pass in negative or zero value of quantity'
      end
    end
  end
end
