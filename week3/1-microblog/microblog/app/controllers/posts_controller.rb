class PostsController < ApplicationController
  def new

  end

  def create
    post = Post.create(post_params)

    puts post

    unless post.blank? || post.invalid?

      # parse post tags
      post.content.scan(/#(\w+)/).flatten.each do |tag|
        t = Tag.find_by(name: tag)
        if t.nil?
          t = Tag.create(name: tag)
        end
        post.tags << t
      end

      redirect_to action: 'show', id: post.id
    end

    redirect_to controller: 'posts', action: 'new' if post.blank? || post.invalid?
  end

  def show

    begin
      @post = Post.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to '/404'
    end

  end

  def destroy
    Post.delete(params[:id])
    redirect_to :root
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
