class PostsController < ApplicationController
  before_action :set_post, only:[:show, :edit, :update]
  before_action :require_user, except: [:show, :index]


  def index
    @posts = Post.all
  end

  def show
    #@post = Post.find(params[:id])  #we are using before action at the top
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user

    if @post.save
      flash[:notice] = "Your post was created."
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
    #@post = Post.find(params[:id]) #we are using before action at the top
  end

  def update
    #@post = Post.find(params[:id])  #we are using before action at the top

    if @post.update(post_params)
      flash[:notice] =  "This post was updated."
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :url, :description)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end

