class CreatePhotoTable < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :url
    end
  end
end
