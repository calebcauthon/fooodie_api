class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token
  
  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

  respond_to :html, :json
  
  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  def cors_preflight_check
    if request.method == 'OPTIONS'
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token'
      headers['Access-Control-Max-Age'] = '1728000'

      render :text => '', :content_type => 'text/plain'
    end
  end

  def options
    render :json => []
  end

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    render :json => @posts
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    render :json => Post.find(params[:id])
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    @post.save
    
    render :json => @post

    #respond_to do |format|
    #  if @post.save
    #    format.html { redirect_to @post, notice: 'Post was successfully created.' }
    #    format.json { render :show, status: :created, location: @post }
    #  else
    #    #format.html { render :new }
    #    format.json { render json: @post.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @post.update(post_params)
    render :json => @post

    #respond_to do |format|
    #  if @post.update(post_params)
    #    format.html { redirect_to @post, notice: 'Post was successfully updated.' }
    #    format.json { render :show, status: :ok, location: @post }
    ##  else
     #   format.html { render :edit }
     #   format.json { render json: @post.errors, status: :unprocessable_entity }
     # end
    #end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    render :json => @post
    #respond_to do |format|
    #  format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
    #  format.json { head :no_content }
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body)
    end
end
