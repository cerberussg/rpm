class Post < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :categories
  has_many :comments, dependent: :destroy
  has_rich_text :content

  validates :title, presence: true
  validates :slug, uniqueness: true, allow_blank: true
  validate :categories_limit

  before_validation :generate_slug
  before_save :set_published_at

  scope :published, -> { where(published: true) }
  scope :recent, -> { order(published_at: :desc).order(created_at: :desc) }

  def display_date
    published_at || created_at
  end

  private

  def generate_slug
    if slug.blank?
      self.slug = title.to_s.parameterize
    end
  end

  def categories_limit
    if categories.size > 4
      errors.add(:categories, "cannot have more than 4 categories")
    end
  end

  def set_published_at
    # Set published_at when post is being published
    if published? && published_at.nil?
      self.published_at = Time.current
    elsif !published?
      # Clear published_at if unpublishing
      self.published_at = nil
    end
  end
end
