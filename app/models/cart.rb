# frozen_string_literal: true
class Cart
  attr_reader :cart_items

  def initialize(cart_items = [])
    @cart_items = []
    cart_items.each do |cart_item|
      raise ArgumentError, 'Should specify product key in cart item array of hash'         unless cart_item.has_key?(:product)
      raise ArgumentError, 'Should not add unavailable product into cart'                  if cart_item[:product].unavailable?
      raise ArgumentError, 'Should not add product in cart with negative or zero quantity' if cart_item.has_key?(:quantity) and cart_item[:quantity] < 1
      @cart_items << CartItem.send(:new,
        product:  cart_item[:product],
        quantity: cart_item.has_key?(:quantity) ? cart_item[:quantity] : 1,
        price:    cart_item.has_key?(:price)    ? cart_item[:price]    : cart_item[:product].price
      )
    end
  end

  def total_price
    cart_items.map(&:total_price).sum
  end

  def has_product?(product)
    cart_items.map(&:product).include? product
  end

  def get_cart_item_by_product(product)
    cart_items.detect { |cart_item| cart_item.product == product }
  end

  def add_item(product, quantity = 1)
    raise ArgumentError, 'Cart cannot add "unavailable" product' if product.unavailable?
    if has_product?(product)
      get_cart_item_by_product(product).increase quantity
    else
      @cart_items << CartItem.send(:new, product: product, quantity: quantity, price: product.price)
    end
  end

  def delete_item(product, quantity = 1)
    raise ArgumentError, 'Should not delete product which is not in the cart item list' unless has_product?(product)
    cart_item = get_cart_item_by_product(product)
    cart_item.decrease quantity
    @cart_items.delete(cart_item) if cart_item.quantity.zero?
  end
end