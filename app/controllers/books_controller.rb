class BooksController < ApplicationController
  def index
    @books = Book.published
  end

  def show
    @book = Book.find_by(slug: params[:slug])

    redirect_to books_path if @book.blank?
  end
end
