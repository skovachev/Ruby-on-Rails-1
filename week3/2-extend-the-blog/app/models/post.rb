# Post class
class Post < ActiveRecord::Base
  belongs_to :data, polymorphic: true
  validates :title, presence: true
  has_and_belongs_to_many :tags

  def is? (type)
    data_type.eql? type
  end

  def data_template
    '/posts/' + data_type.downcase
  end
end
