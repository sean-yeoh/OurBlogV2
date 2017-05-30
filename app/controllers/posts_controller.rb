class PostsController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  def index
    @posts = Post.all
    @years = @posts.map {|post| post.created_at.year}.uniq
    @posts_archive = @posts.group_by {|post| [post.created_at.year, post.created_at.month]}
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_admin.posts.new(post_params)

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def show
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  def upload_image
    image = TinymceAsset.create(image: params[:file])
    render json: { image: { url: image.image_url } }, content_type: 'text/html'
  end

  private
  def set_post
      @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
