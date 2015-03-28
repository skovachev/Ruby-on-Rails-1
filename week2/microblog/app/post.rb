require_relative 'tag'

class Post
  
  class << self
    def find_by_id(id)
      row = $db.execute("select id, title, content from posts where id=?", [id]).first
      post = Post.new(row[1], row[2], row[0]) unless row.nil?
      # get tags for post
      unless post.nil?
        post.tags = Tag.find_for_post(post.id).map do |tag|
          tag.name
        end
      end
      post
    end

    def find_all
      $db.execute("select id, title, content from posts").map do |row|
        post = Post.new(row[1], row[2], row[0])
          # get tags for post
        post.tags = Tag.find_for_post(post.id).map do |tag|
          tag.name
        end
        post
      end
    end

    def delete_by_id(id)
      $db.execute("delete from posts where id=?", [id])
    end

    def find_by_tag(tag)
      sql = <<-EOT
        SELECT posts.id, title, content FROM posts 
          LEFT JOIN post_tags ON posts.id=post_tags.post_id
          LEFT JOIN tags ON post_tags.tag_id=tags.id
        WHERE tags.name = ?
      EOT
      $db.execute(sql, [tag]).map do |row|
        post = Post.new(row[1], row[2], row[0])
        # get tags for post
        post.tags = Tag.find_for_post(post.id).map do |t|
          t.name
        end
        post
      end
    end

    def insert(post)
      data = [post.title, post.content]

      # TODO must be in transaction
      $db.execute("insert into posts(title, content) values ( ?, ? )", data)
      post_id = $db.execute('SELECT last_insert_rowid()');

      post.tags.each do |tag|
        Tag.insert_if_not_exists tag, post_id
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
