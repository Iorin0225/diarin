class Article < ApplicationRecord
  OFFICIAL_STATUSES = %w[draft publish private deleted]

  belongs_to :book

  # scope :published, -> { where('published_at < ?', Time.zone.now) }
  scope :published, -> { where(status: :publish) }

  scope :with_year, -> (year) {
    start_date = Time.zone.local(year.to_i, 1, 1).beginning_of_year
    end_date = start_date.end_of_year
    where(published_at: start_date..end_date)
  }
  scope :with_year_month, -> (year, month) {
    start_date = Time.zone.local(year.to_i, month.to_i, 1).beginning_of_month
    end_date = start_date.end_of_month
    where(published_at: start_date..end_date)
  }
  scope :search, -> (key) {
    where('title LIKE ? OR body LIKE ?', "%#{key}%", "%#{key}%")
  }

  def prev_article
    @prev_article ||= book.articles.published.where('published_at < ?', published_at).order(published_at: :desc).first
  end

  def next_article
    @next_article ||= book.articles.published.where('published_at > ?', published_at).order(published_at: :asc).first
  end
end
