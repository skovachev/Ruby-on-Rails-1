# Product class
class Product < ActiveRecord::Base
  validates :name, presence: true
  validates :price, presence: true
  validates :stock, presence: true

  belongs_to :brand
  belongs_to :category
end
