# Photo class
class Photo < ActiveRecord::Base
  has_many :posts, as: :data
  validates :url, presence: true
end
