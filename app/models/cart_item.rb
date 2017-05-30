# frozen_string_literal: true
class CartItem
  private_class_method :new
  attr_reader   :product
  attr_accessor :quantity, :price

  def initialize(params)
    @product  = params[:product]
    @quantity = params.has_key?(:quantity) ? params[:quantity] : 1
    @price    = params.has_key?(:price)    ? params[:price]    : params[:product].price
  end

  def total_price
    quantity * price
  end

  def increase(quantity = 1)
    raise ArgumentError, 'increase quantity should be larger than zero' if quantity < 1
    self.quantity += quantity
  end

  def decrease(quantity = 1)
    raise ArgumentError, 'Should not decrease value over than cart_item quantity itself' if quantity > self.quantity
    raise ArgumentError, 'decrease quantity should be larger than zero'                  if quantity < 1
    self.quantity -= quantity
  end
end
