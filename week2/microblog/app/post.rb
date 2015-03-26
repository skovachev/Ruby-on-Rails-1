class Post
  attr_accessor :title, :content, :id, :tags

  @tags = []

  def initialize(title, content)
    @title, @content = title, content
  end

  def valid?
    title_valid = (@title.is_a? String) && @title.present?
    content_valid = (@content.is_a? String) && @content.present?
    content_not_too_long = @content.length < 256
    title_valid && content_valid && content_not_too_long
  end
end
