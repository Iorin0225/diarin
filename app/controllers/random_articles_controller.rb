class RandomArticlesController < ApplicationController
  allow_unauthenticated_access only: [:index]

  def index
    @book = Book.find_by(slug: params[:book_slug])
    @random_article = RandomArticle.new(book: @book)
    @article = @random_article.article
  end
end
