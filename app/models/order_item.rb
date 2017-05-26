class OrderItem < ApplicationRecord
  acts_as_paranoid
  belongs_to :order
  belongs_to :product

  validates :quantity, :price, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :price,    numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
