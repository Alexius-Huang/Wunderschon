# frozen_string_literal: true
class CreateOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :order_items do |t|
      t.references :order, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :quantity
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :order_items, :deleted_at
  end
end
