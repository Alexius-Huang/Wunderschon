class Product < ApplicationRecord
  include AASM
  acts_as_paranoid
  belongs_to :category

  enum status: Settings.product.statuses

  validates :title, :description, :price, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  aasm column: :status, enum: true do
    state :unavailable, initial: true
    state :available

    event :open do
      transitions from: :unavailable, to: :available
    end

    event :close do
      transitions from: :available, to: :unavailable
    end
  end
end
