class Post
    attr_accessor :title, :content, :id, :tags

    @tags = []

    def initialize(title, content)
        @title, @content = title, content
    end

    def valid?
        (@title.is_a? String) && @title.present? && (@content.is_a? String) && @content.present? && @content.length < 256
    end
end