class Lecture < ActiveRecord::Base
    validates_presence_of :name, :description
    has_many :tasks
end