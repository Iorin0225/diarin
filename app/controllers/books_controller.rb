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
    if year.present? && month.present?
      @articles = @articles.with_year_month(year, month)
    elsif year.present?
      @articles = @articles.with_year(year)
    end
  end
end
