class Book < ApplicationRecord
  has_many :articles, dependent: :destroy

  scope :published, -> { where('published_at < ?', Time.zone.now) }

  def to_param
    slug
  end
end
