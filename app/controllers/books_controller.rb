class BooksController < ApplicationController
  def index
    @books = Book.published
  end

  def show
    @book = Book.find_by(slug: params[:slug])
    redirect_to books_path if @book.blank?
    @articles = @book.articles.published.order(published_at: :desc).limit(100)

    year = params[:year].to_i if params[:year].present?
    month = params[:month].to_i if params[:month].present?
    @articles = filter_by_year_month(@articles, year, month)

    search_param = params[:search]
    @articles = filter_by_seach_params(@articles, search_param)
  end

  private
    def filter_by_year_month(articles, year, month)
      if year.present? && month.present?
        articles.with_year_month(year, month)
      elsif year.present?
        articles.with_year(year)
      else
        articles
      end
    end

    def filter_by_seach_params(articles, search_param)
      search_keys = search_param.to_s.split(/\s+/)
      search_keys.each do |key|
        articles = articles.search(key)
      end
      articles
    end
end
