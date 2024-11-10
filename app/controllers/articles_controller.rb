class ArticlesController < ApplicationController
  def index
  end

  def show
    @article = Article.find(params[:id])

    redirect_to books_path if @article.nil?

    @book = @article.book
  end
end
