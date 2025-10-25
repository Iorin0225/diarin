class RandomArticle
  include ActiveModel::Model

  attr_reader :article, :book

  def initialize(book: nil)
    @book = book
  end

  def article
    @article ||= fetch_random_article
  end

  private

  def fetch_random_article
    if @book.present?
      book.articles.published.sample
    else
      Article.published.sample
    end
  end
end
