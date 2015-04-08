class CreateArticleTable < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.text :content
    end
  end
end
