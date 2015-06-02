# Brand class
class Brand < ActiveRecord::Base
  validates :name, presence: true
  validates :short_description, presence: true
end
