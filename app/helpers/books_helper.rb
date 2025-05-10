module BooksHelper
  def book_updated_label(book)
    book_updated_at = book.articles.published.last&.published_at

    return '' if book_updated_at.nil?

    return "#{date_only(book_updated_at)} 更新"

  end
end
