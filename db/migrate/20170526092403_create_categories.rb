# frozen_string_literal: true
class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :title
      t.text :description
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :categories, :deleted_at
  end
end
