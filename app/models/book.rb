class Book < ApplicationRecord
  has_many :articles, dependent: :destroy

  scope :published, -> { where('published_at < ?', Time.zone.now) }

  def to_param
    slug
  end

  def year_months
    @year_months ||= {}
    articles.published.group("strftime('%Y-%m', published_at)").order(published_at: :desc).select("strftime('%Y%m', published_at) as year_month, count(*) as count").map do |article|
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