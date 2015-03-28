require_relative 'post'
require_relative 'tag'
require_relative 'support'
require_relative 'setupdb'

class App
  include Enumerable

  attr_reader :posts

  def all_tags
    Tag.find_all.map(&:name)
  end

  def all_posts
    Post.find_all
  end

  def each(&block)
    @posts.each(&block)
  end

  def initialize(posts = {})
    @posts = posts
    @posts_by_tag = {}
  end

  def extract_tags(content)
    content.scan(/#(\w+)/).flatten
  end

  def posts_for_tag(tag)
    Post.find_by_tag tag
    # @posts_by_tag[tag].map { |post_id| @posts[post_id] }.compact
  end

  def add_post(title, content)
    post = Post.new title, content
    valid = post.valid?
    if valid
      # get post tags
      tags = extract_tags content

      # save post and tags
      post.tags = tags
      Post.insert post;
      # @posts[post.id] = post
    end
    valid ? post : nil
  end

  def get_post(id)
    Post.find_by_id id
    # @posts[id.to_i]
  end

  def delete_post(id)
    Post.delete_by_id id
    # @posts.delete id.to_i
  end
end
