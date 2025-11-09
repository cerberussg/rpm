class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: [:destroy]
  before_action :require_authentication

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = Current.user

    if @comment.save
      redirect_to post_path(@post.slug), notice: "Comment added successfully."
    else
      @comments = @post.comments.recent
      render "posts/show", status: :unprocessable_entity
    end
  end

  def destroy
    if @comment.user == Current.user || Current.user&.admin?
      @comment.destroy
      redirect_to post_path(@post.slug), notice: "Comment deleted."
    else
      redirect_to post_path(@post.slug), alert: "You can only delete your own comments."
    end
  end

  private

  def set_post
    @post = Post.find_by!(slug: params[:post_slug])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
