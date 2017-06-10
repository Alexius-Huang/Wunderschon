# frozen_string_literal: true
class Category < ApplicationRecord
  acts_as_paranoid
  has_many :products, dependent: :destroy

  validates :title, :description, presence: true

  def available_products
    products.where(category_id: self, status: 'available')
  end
end
