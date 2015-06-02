# Category class
class Category < ActiveRecord::Base
  validates :name, presence: true
end
