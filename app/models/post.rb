class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  has_many :comments, dependent: :destroy
  has_rich_text :content

  validates :title, presence: true
  validates :slug, uniqueness: true, allow_blank: true

  before_validation :generate_slug

  scope :published, -> { where(published: true) }
  scope :recent, -> { order(created_at: :desc) }

  def category_name
    category&.name || category_before_type_cast
  end

  private

  def generate_slug
    if slug.blank?
      self.slug = title.to_s.parameterize
    end
  end
end
