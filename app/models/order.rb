class Order < ApplicationRecord
  include AASM
  acts_as_paranoid
  has_many :order_items, dependent: :destroy
  enum status: Settings.order.statuses

  validates :name, :email, :address, :tel, presence: true

  aasm column: :status, enum: true do
    state :pending, initial: true
    state :paid
    state :cancelled
    state :delivered
    state :rejected
    
    event :pay do
      transitions from: :pending, to: :paid
    end

    event :cancel do
      transitions from: :pending, to: :cancelled
    end

    event :deliver do
      transitions from: :paid, to: :delivered
    end

    event :reject do
      transitions from: :delivered, to: :rejected
    end
  end

  def total_price
    order_items.map(&:total_price).sum
  end

  def has_product?(product)
    !order_items.where(product: product).empty?
  end

  def get_order_item_by_product(product)
    order_items.where(product: product).first
  end

  def add_item(product, quantity = 1)
    raise_product_unavailable_error(product) if product.unavailable?
    raise_negative_or_zero_quantity_error    if quantity < 1
    if has_product?(product)
      get_order_item_by_product(product).increase!(quantity)
    else
      order_items.create(product: product, price: product.price, quantity: quantity)
    end
  end

  def delete_item(product, quantity = 1)
    raise_product_not_in_order_list(product) unless self.has_product?(product) 
    raise_negative_or_zero_quantity_error    if quantity < 1
    get_order_item_by_product(product).decrease!(quantity)
  end

  private

  def raise_product_unavailable_error(product)
    raise ActiveRecord::Rollback, "#{product.title} is unavailable"
  end

  def raise_negative_or_zero_quantity_error
    raise ActiveRecord::Rollback, 'should pass in quantity larger than zero'
  end

  def raise_product_not_in_order_list(product)
    raise ActiveRecord::Rollback, "#{product.title} is not in order item list"
  end
end
