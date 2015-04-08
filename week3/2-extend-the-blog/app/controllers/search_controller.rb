class SearchController < ApplicationController
  def tag
    @tag = Tag.find_by(name: params[:tag])
    @posts = @tag.posts
  end
end
