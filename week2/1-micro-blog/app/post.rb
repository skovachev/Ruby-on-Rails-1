require_relative 'tag'

class Post
  class << self
    def build_from_db(row)
      post = Post.new(row[1], row[2], row[0]) unless row.nil?
      # get tags for post
      post.tags = Tag.find_for_post(post.id).map(&:name) unless post.nil?

      post
    end

    def find_by_id(id)
      sql = 'SELECT id, title, content FROM posts WHERE id=?'
      row = DB.get_first_row(sql, [id])
      Post.build_from_db row
    end

    def find_all
      DB.execute('SELECT id, title, content FROM posts').map do |row|
        Post.build_from_db row
      end
    end

    def delete_by_id(id)
      DB.execute('DELETE FROM posts WHERE id=?', [id])
    end

    def find_by_tag(tag)
      sql = <<-EOT
        SELECT posts.id, title, content FROM posts
          LEFT JOIN post_tags ON posts.id=post_tags.post_id
          LEFT JOIN tags ON post_tags.tag_id=tags.id
        WHERE tags.name = ?
      EOT
      DB.execute(sql, [tag]).map do |row|
        Post.build_from_db row
      end
    end

    def insert(post)
      data = [post.title, post.content]

      DB.transaction do
        DB.execute('INSERT INTO posts(title, content) VALUES (?, ?)', data)
        post_id = DB.execute('SELECT last_insert_rowid()')

        post.tags.each do |tag|
          Tag.insert_if_not_exists tag, post_id
        end
      end
    end
  end

  attr_accessor :title, :content, :id, :tags

  @tags = []

  def initialize(title, content, id = nil)
    @title, @content, @id = title, content, id
  end

  def valid?
    title_valid = (@title.is_a? String) && @title.present?
    content_valid = (@content.is_a? String) && @content.present?
    content_not_too_long = @content.length < 256
    title_valid && content_valid && content_not_too_long
  end
end
