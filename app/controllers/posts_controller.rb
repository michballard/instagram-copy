class PostsController < ApplicationController
	before_action :authenticate_user!, except: [:index]
	
  def index
  	@posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create

  	@post = Post.create(params[:post].permit(:title, :image, :tag_list))
    # @post.save
  	redirect_to posts_path
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(params[:post].permit(:title, :image, :tag_list))
    redirect_to posts_path
  end

  def destroy
  	@post = Post.find(params[:id])
  	@post.destroy
  	flash[:notice] = 'Post successfully deleted'
  	redirect_to posts_path
  end

end
