class Post < ActiveRecord::Base
    # attr_accessor :title, :content

    validates :title, :presence => true
    validates :content, :presence => true, :length => {:in => 3..200}

    has_and_belongs_to_many :tags
end
