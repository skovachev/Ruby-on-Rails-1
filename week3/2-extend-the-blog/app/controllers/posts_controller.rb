# Posts controller
class PostsController < ApplicationController
  def new
  end

  def create
    post = Post.create(post_params)
    post_invalid = post.blank? || post.invalid?

    unless post_invalid
      # parse post tags
      process_post_tags post
      redirect_to action: 'show', id: post.id
    end

    redirect_to controller: 'posts', action: 'new' if post_invalid
  end

  def show
    @post = Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to '/404'
  end

  def destroy
    Post.delete(params[:id])
    redirect_to :root
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def process_post_tags(post)
    post.content.scan(/#(\w+)/).flatten.each do |tag|
      t = Tag.find_by(name: tag)
      t = Tag.create(name: tag) if t.nil?
      post.tags << t
    end
  end
end
