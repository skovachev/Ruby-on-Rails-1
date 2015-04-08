class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.integer :data_id
      t.string :data_type

      t.timestamps null: false
    end

    add_index :posts, :data_id
    add_index :posts, :data_type
  end
end
