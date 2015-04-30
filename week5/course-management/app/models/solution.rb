class Solution < ActiveRecord::Base
    validates_presence_of :body
    belongs_to :task
end