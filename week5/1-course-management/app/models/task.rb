class Task < ActiveRecord::Base
  validates_presence_of :name, :description
  belongs_to :lecture
  has_many :solutions
end
