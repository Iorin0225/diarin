class Article < ApplicationRecord
  belongs_to :book

  scope :published, -> { where('published_at < ?', Time.zone.now) }

  scope :with_year, -> (year) {
    start_date = Date.new(year.to_i, 1, 1).beginning_of_year
    end_date = start_date.end_of_year
    where(published_at: start_date..end_date)
  }
  scope :with_year_month, -> (year, month) {
    start_date = Date.new(year.to_i, month.to_i, 1).beginning_of_month
    end_date = start_date.end_of_month
    where(published_at: start_date..end_date)
  }
end
