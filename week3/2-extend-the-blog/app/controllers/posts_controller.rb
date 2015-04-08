# Posts controller
class PostsController < ApplicationController
  def new
  end

  def create
    post = Post.create(post_params)
    article = Article.create(article_params)
    post.update_attribute(:data, article)

    post_invalid = post.blank? || post.invalid? || article.blank? || article.invalid?

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
    post = Post.find(params[:id])
    unless post.nil?
      post.data.delete
      post.delete
    end
    redirect_to :root
  end

  private

  def post_params
    params.require(:post).permit(:title)
  end

  def article_params
    params.require(:post).permit(:content)
  end

  def process_post_tags(post)
    post.data.content.scan(/#(\w+)/).flatten.each do |tag|
      t = Tag.find_by(name: tag)
      t = Tag.create(name: tag) if t.nil?
      post.tags << t
    end
  end
end
