# frozen_string_literal: true
class AddPriceToOrderItem < ActiveRecord::Migration[5.1]
  def change
    add_column :order_items, :price, :integer
  end
end
