# frozen_string_literal: true
class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :email
      t.string :address
      t.string :tel
      t.string :status
      t.text :remark
      t.text :comment
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :orders, :deleted_at
  end
end
