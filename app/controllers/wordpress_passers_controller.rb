class WordpressPassersController < ApplicationController
  allow_unauthenticated_access only: :show

  before_action :set_book, only: [:show]
  before_action :set_article, only: [:show]

  def show
    if @article.nil?
      redirect_to book_path(@book)
    else
      redirect_to article_path(@article)
    end
  end

  private
    def set_book
      @book = Book.find_by(slug: params[:book_slug])
      head :not_found if @book.nil?
    end

    def set_article
      @article = @book.articles.find_by(imported_id: params[:id])
      head :not_found if @article.nil?
    end
end
