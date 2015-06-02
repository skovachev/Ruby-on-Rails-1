class HomeController < ApplicationController
  def index
    @posts = Post.all
    @tags = Tag.all
  end

  def page_not_found

  end

end
