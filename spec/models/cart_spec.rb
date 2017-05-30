# frozon_string_literal: true
require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:product_item_array) do
    [
      { product: create(:product), quantity: rand(3..10) },
      { product: create(:product), quantity: rand(3..10) }
    ]
  end
  let(:cart)                { described_class.new product_item_array }
  let(:sample_cart_item)    { cart.cart_items.sample }
  let(:sample_product)      { sample_cart_item.product }
  let(:new_product)         { create(:product) }
  let(:unavailable_product) { create(:product, :unavailable) }

  describe 'initialize' do
    it 'can initialize new cart without any params' do
      cart = described_class.new
      expect(cart.cart_items).to be_kind_of Array
      expect(cart.cart_items).to be_empty
    end

    it 'can initialize an array of product with quantity hash' do
      expect(cart.cart_items).to be_kind_of Array
      expect(cart.cart_items.size).to be 2
    end

    context 'invalid' do
      subject { described_class.new(product_item_array) }

      it 'should raise ArgumentError if not specify the product in initialize cart_item hash' do
        product_item_array << { quantity: rand(1..10) }
        error_msg = 'Should specify product key in cart item array of hash'
        expect { subject }.to raise_error(ArgumentError, error_msg)
      end

      it 'should raise ArgumentError if initialize cart_items with unavailable product' do
        product_item_array << { product: unavailable_product }
        error_msg = 'Should not add unavailable product into cart'
        expect { subject }.to raise_error(ArgumentError, error_msg)
      end

      it 'should raise ArgumentError if initialize cart_item with negative or zero value of quantity' do
        product_item_array << { product: new_product, quantity: rand(-1..0) }
        error_msg = 'Should not add product in cart with negative or zero quantity'
        expect { subject }.to raise_error(ArgumentError, error_msg)
      end
    end
  end

  describe 'class methods' do
    describe '.from_hash' do
      it 'can initialize new cart with cart hash'
    end
  end

  describe 'instance methods' do
    describe '.cart_items' do
      it 'should get array of cart_item objects' do
        cart.cart_items { |cart_item| expect(cart_item).to be_kind_of CartItem }
      end
    end

    describe '.total_price' do
      it 'should get the total price of the cart' do
        expect(cart.total_price).to eq cart.cart_items.map(&:total_price).sum
      end
    end

    describe '.product_exist?' do
      it 'should returns true if product exist from cart items of cart' do
        expect(cart.has_product?(new_product)).to be_falsey
        expect(cart.has_product?(cart.cart_items.sample.product)).to be_truthy
      end
    end

    describe '.get_cart_item_by_product' do
      it 'should get the product if product exist in cart items of cart' do
        expect(cart.get_cart_item_by_product(sample_product)).to eq sample_cart_item
      end

      it 'should return nil if product isn\'t exist in cart items of cart' do
        expect(cart.get_cart_item_by_product(new_product)).to be_nil
      end
    end

    shared_examples 'pass in negative or zero quantity' do |method|
      it 'should raise ArgumentError' do
        error_msg = case method
                    when :add_item    then 'increase'
                    when :delete_item then 'decrease'
                    end
        error_msg += ' quantity should be larger than zero'
        expect { cart.send(method, sample_product, rand(-1..0)) }.to raise_error(ArgumentError, error_msg)
      end
    end

    describe '.add_item' do
      context 'basic utility' do
        it 'should add the quantity default as one if product already in cart item list' do
          quantity = sample_cart_item.quantity
          cart.add_item sample_product
          expect(cart.get_cart_item_by_product(sample_product).quantity).to eq quantity.next
        end

        it 'should create new cart item of the cart if product no exist originally' do
          cart.add_item new_product
          expect(cart.cart_items.size).to eq 3
          expect(cart.has_product?(new_product)).to be_truthy
          expect(cart.get_cart_item_by_product(new_product).quantity).to eq 1
        end

        it 'can pass second parameter represent the quantity of the cart item to add' do
          increase_quantity = rand(1..10)
          quantity = sample_cart_item.quantity
          cart.add_item(sample_product, increase_quantity)
          expect(cart.get_cart_item_by_product(sample_product).quantity).to eq (quantity + increase_quantity)
        end
      end

      context 'invalid' do
        it_should_behave_like 'pass in negative or zero quantity', :add_item
        it 'should not add "unavailable" product' do
          error_msg = 'Cart cannot add "unavailable" product'
          expect { cart.add_item(unavailable_product) }.to raise_exception(ArgumentError, error_msg)
          sample_product.close!
          expect(sample_product.unavailable?).to be_truthy
          expect { cart.add_item(sample_product) }.to raise_exception(ArgumentError, error_msg)
        end
      end
    end

    describe '.delete_item' do
      context 'basic utility' do
        it 'should delete the quantity default as one if product already in cart item list' do
          quantity = sample_cart_item.quantity
          cart.delete_item sample_product
          expect(cart.get_cart_item_by_product(sample_product).quantity).to eq (quantity - 1)
        end

        it 'can pass second parameter represent the quantity of the cart item to delete' do
          quantity = sample_cart_item.quantity
          decrease_quantity = rand(2..quantity - 1)
          cart.delete_item(sample_product, decrease_quantity)
          expect(cart.get_cart_item_by_product(sample_product).quantity).to eq (quantity - decrease_quantity)
        end

        it 'can pass in "unavailable" product if exist in cart item list' do
          sample_product.close!
          quantity = sample_cart_item.quantity
          cart.delete_item sample_product
          expect(sample_product.unavailable?).to be_truthy
          expect(cart.get_cart_item_by_product(sample_product).quantity).to eq (quantity - 1)
        end

        it 'should remove cart_item if quantity is decreased to zero' do
          expect(cart.cart_items.size).to eq 2
          quantity = cart.get_cart_item_by_product(sample_product).quantity
          cart.delete_item(sample_product, quantity)
          expect(cart.cart_items.size).to eq 1
        end
      end

      context 'invalid' do
        it_should_behave_like 'pass in negative or zero quantity', :delete_item
        it 'should not pass in the product which is not in the cart item list' do
          error_msg = 'Should not delete product which is not in the cart item list'
          expect { cart.delete_item new_product }.to raise_exception(ArgumentError, error_msg)
        end
      end
    end

    describe '.to_hash' do
      it 'should convert the cart details into a hash value'
    end

    describe '.checkout!' do
      context 'basic utility' do
        it 'should create order and order_items from the cart detail and user provided data'
        it 'should clear cart_items of the cart after checkout successfully'
      end

      context 'invalid' do
        it 'should not checkout if the user provided data is empty or invalid'
        it 'should not checkout if the cart is empty'
      end
    end
  end
end