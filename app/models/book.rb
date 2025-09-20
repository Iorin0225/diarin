class Book < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_user_id
  has_many :articles, dependent: :destroy

  scope :published, -> { where('published_at < ?', Time.zone.now) }

  FIRST_VIEW_TYPES = %w[list latest_article].freeze
  COLORS = %w[auto red green blue yellow pink purple].freeze

  def to_param
    slug
  end

  def year_months
    @year_months ||= {}
    articles.published
            .group("strftime('%Y-%m', datetime(published_at, '+9 hours'))")
            .order("published_at DESC")
            .select("strftime('%Y%m', datetime(published_at, '+9 hours')) as year_month, count(*) as count")
            .map do |article|
      year_month_int = article.year_month.to_i
      year = year_month_int / 100
      month = year_month_int % 100
      {
        year: year,
        month: month,
        count: article.count
      }
    end
  end
end
