class Admin::PostsController < ApplicationController
  before_action :require_admin
  before_action :set_post, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all.recent
  end

  def new
    @post = Post.new
  end

  def create
    @post = Current.user.posts.build(post_params)

    if @post.save
      redirect_to admin_posts_path, notice: "Post created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to admin_posts_path, notice: "Post updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to admin_posts_path, notice: "Post deleted successfully."
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :published, :slug, category_ids: [])
  end

  def require_admin
    unless Current.user&.admin?
      redirect_to root_path, alert: "Access denied. Admin only."
    end
  end
end
