class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.integer :price
      t.string :status
      t.references :category, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
    add_index :products, :deleted_at
  end
end
