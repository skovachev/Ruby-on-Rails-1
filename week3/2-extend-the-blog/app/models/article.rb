# Article class
class Article < ActiveRecord::Base
  has_many :posts, as: :data
  validates :content, presence: true, length: { in: 3..200 }
end
