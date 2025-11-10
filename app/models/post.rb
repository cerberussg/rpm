class Post < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :categories
  has_many :comments, dependent: :destroy
  has_rich_text :content

  validates :title, presence: true
  validates :slug, uniqueness: true, allow_blank: true
  validate :categories_limit

  before_validation :generate_slug

  scope :published, -> { where(published: true) }
  scope :recent, -> { order(created_at: :desc) }

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
end
