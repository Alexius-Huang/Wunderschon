class Order < ApplicationRecord
  include AASM
  has_many :order_items
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
end
