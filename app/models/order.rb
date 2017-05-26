class Order < ApplicationRecord
  has_many :order_items

  validates :name, :email, :address, :tel, presence: true
end
