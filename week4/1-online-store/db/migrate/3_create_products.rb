# CreateProducts
class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.integer :stock, null: false, default: 0
      t.decimal :price, null: false
      t.timestamps null: false

      t.belongs_to :category, null: false
      t.belongs_to :brand, null: false
    end
  end
end
