class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.integer :stock, null: false, default: 0
      t.decimal :price, null: false
      t.timestamps null: false

      t.integer :category_id, null: false, index: true
      t.integer :brand_id, null: false, index: true
    end
  end
end
