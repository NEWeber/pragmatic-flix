class Movie < ApplicationRecord

  before_save :set_slug

  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user
  has_many :critics, through: :reviews, source: :user
  has_many :characterizations, dependent: :destroy
  has_many :genres, through: :characterizations

  has_one_attached :main_image

  validate :acceptable_image

  validates :title, presence: true, uniqueness: true
  validates :released_on, :duration, presence: true

  validates :description, length: { minimum: 25 }

  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }

  RATINGS = %W(G PG PG-13 R NC-17 #{"Not Rated"})
  validates :rating, inclusion: { in: RATINGS }

  scope :released, -> { where("released_on < ?", Time.now).order("released_on desc") }
  scope :upcoming, -> { where("released_on > ?", Time.now).order("released_on asc") }
  scope :recent, ->(max = 5) { released.limit(max) }
  scope :hits, -> { released.where("total_gross >= 300000000").order(total_gross: :desc) }
  scope :flops, -> { released.where(total_gross: ..225_000_000).order("total_gross asc")
}

  def flop?
    total_gross < 225_000_000 || (reviews.count >= 50 && reviews.average_stars >= 4.0)
  end

  def average_stars
    reviews.average(:stars) || 0.0
  end

  def average_stars_as_percent
    (average_stars / 5.0) * 100.0
  end

  def to_param
    slug
  end

  private
    def set_slug
      self.slug = title.parameterize
    end

    def acceptable_image
      return unless main_image.attached?

      unless main_image.byte_size <= 1.megabyte
        errors.add(:main_image, "image file too large, make under 1 megabyte")
      end
      acceptable_types = ["image/png", "image/jpeg"]
      unless acceptable_types.include?(main_image.content_type)
        errors.add(:main_image, "image must be PNG or JPEG")
      end
    end

end
