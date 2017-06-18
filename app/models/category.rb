# frozen_string_literal: true
class Category < ApplicationRecord
  acts_as_paranoid
  has_many :products, dependent: :destroy

  validates :title, :description, presence: true

  scope :paginate, ->(options = {}) {
    order(options[:sort_by] || :title)
      .page(options[:page] || params[:page])
      .per(options[:per] || 10)
  }

  def info
    {
      id: id,
      title: title,
      description: description
    }
  end

  def available_products
    products.where(category_id: self, status: 'available')
  end
end
