class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token
  
  respond_to :json
  
  def index
    @posts = Post.all
    render :json => @posts.to_json(:include => :user)
  end

  def show
    render :json => Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.save    
    render :json => @post
  end

  def update
    @post.update(post_params)
    render :json => @post
  end

  def destroy
    @post.destroy
    render :json => @post
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body)
    end
end
