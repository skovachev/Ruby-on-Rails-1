require 'sinatra'
require_relative 'app/app'

app = App.new

enable :sessions
set :public_folder, proc { File.join(root, 'public') }

# show posts list
get '/' do
  all_posts = app.all_posts.compact
  tags = app.all_tags
  erb :index, locals: { posts: all_posts, tags: tags }
end

# show post form
get '/new' do
  erb :post_new
end

post '/new' do
  post = app.add_post(params[:title], params[:content])

  if post.nil?
    # with post data
    redirect '/new'
  end

  # handle if success != true
  redirect '/' + post.id.to_s
end

get '/:id' do
  post = app.get_post(params[:id])

  if post.nil?
    status 404
    erb :oops
  else
    # render post view
    erb :post, locals: { post: post }
  end
end

delete '/:id' do
  app.delete_post(params[:id])
  # respond based on success -> send different message
  redirect '/'
end

get '/search/:tag' do
  tag = params[:tag]
  posts = app.posts_for_tag tag

  erb :by_tag, locals: { tag: tag, posts: posts }
end

# 404 Error!
not_found do
  status 404
  erb :oops
end
