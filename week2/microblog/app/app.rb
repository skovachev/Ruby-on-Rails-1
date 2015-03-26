require_relative 'post'
require_relative 'support'

class App
  @next_post_id = 1

  class << self
    def next_post_id
      @next_post_id += 1
    end
  end

  class << self
    @post_id = 1

    def generate_post_id
      App.post_id += 1
    end
  end

  include Enumerable

  attr_reader :posts

  def all_tags
    @posts_by_tag.keys
  end

  def each(&block)
    @posts.each(&block)
  end

  def initialize(posts = {})
    @posts = posts
    @posts_by_tag = {}
  end

  def index_post_by_tags(post_id, content)
    tags = content.scan(/#(\w+)/).flatten
    tags.each do |tag|
      @posts_by_tag[tag] = [] unless @posts_by_tag.key?(tag)
      @posts_by_tag[tag] << post_id
    end
  end

  def posts_for_tag(tag)
    @posts_by_tag[tag].map { |post_id| @posts[post_id] }.compact
  end

  def add_post(title, content)
    post = Post.new title, content
    valid = post.valid?
    if valid
      post.id = App.next_post_id

      # get post tags
      tags = index_post_by_tags post.id, content

      # save post and tags
      post.tags = tags
      @posts[post.id] = post
    end
    valid ? post : nil
  end

  def get_post(id)
    @posts[id.to_i]
  end

  def delete_post(id)
    @posts.delete id.to_i
  end
end
