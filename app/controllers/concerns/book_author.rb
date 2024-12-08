module BookAuthor
  extend ActiveSupport::Concern

  included do
    helper_method :author?
  end

  private
    def author?(book_or_article)
      return false unless authenticated?

      if book_or_article.is_a?(Book)
        book_or_article.author == Current.user
      elsif book_or_article.is_a?(Article)
        book_or_article.book.author == Current.user
      end
    end
end
