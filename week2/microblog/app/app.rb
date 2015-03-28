require_relative 'post'
require_relative 'tag'
require_relative 'support'
require_relative 'setupdb'

class App
  def all_tags
    Tag.find_all.map(&:name)
  end

  def all_posts
    Post.find_all
  end

  def extract_tags(content)
    content.scan(/#(\w+)/).flatten
  end

  def posts_for_tag(tag)
    Post.find_by_tag tag
  end

  def add_post(title, content)
    post = Post.new title, content
    valid = post.valid?
    if valid
      # get post tags
      tags = extract_tags content

      # save post and tags
      post.tags = tags
      Post.insert post
    end
    valid ? post : nil
  end

  def get_post(id)
    Post.find_by_id id
  end

  def delete_post(id)
    Post.delete_by_id id
  end
end
