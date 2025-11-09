class PostsController < ApplicationController
  allow_unauthenticated_access
  before_action :resume_session

  def index
    @posts = Post.published.recent
  end

  def show
    @post = Post.published.find_by!(slug: params[:slug])
    @comment = Comment.new
    @comments = @post.comments.recent
  end
end
