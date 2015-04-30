class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.text :body, null: false
      t.belongs_to :task, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
