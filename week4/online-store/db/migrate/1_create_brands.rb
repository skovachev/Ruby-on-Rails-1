class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name, null: false, unique: true
      t.text :short_description, null: false
      t.timestamps null: false
    end
  end
end
