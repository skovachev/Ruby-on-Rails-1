# Photos controller
class PhotosController < ApplicationController
  def new
  end

  def index
    @photos = Post.where(data_type: 'Photo')
  end

  def create
    post = Post.create(post_params)
    photo = Photo.create(photo_params)
    post.update_attribute(:data, photo)

    post_invalid = post.blank? || post.invalid? || photo.blank? || photo.invalid?

    redirect_to controller: 'posts', action: 'show', id: post.id unless post_invalid

    redirect_to controller: 'photos', action: 'new' if post_invalid
  end

  private

  def post_params
    params.require(:post).permit(:title)
  end

  def photo_params
    params.require(:post).permit(:url)
  end
end
