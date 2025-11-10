class Admin::DashboardController < ApplicationController
  layout "admin"
  before_action :require_admin

  def index
    @users_count = User.count
    @posts_count = Post.count
    @categories_count = Category.count

    # Top 10 commenters
    @top_commenters = User.joins(:comments)
                          .select('users.*, COUNT(comments.id) as comments_count')
                          .group('users.id')
                          .order('comments_count DESC')
                          .limit(10)

    # 10 most recent posts
    @recent_posts = Post.includes(:user, :categories)
                        .order(created_at: :desc)
                        .limit(10)

    # 10 most used categories
    @top_categories = Category.joins(:posts)
                              .select('categories.*, COUNT(posts.id) as posts_count')
                              .group('categories.id')
                              .order('posts_count DESC')
                              .limit(10)
  end

  private

  def require_admin
    unless Current.user&.admin?
      redirect_to root_path, alert: "Access denied. Admin only."
    end
  end
end
