class Api::V1::ArticlesController < ActionController::API

  DEFAULT_LIMIT = 20
  MAX_LIMIT = 100

  def index
    @articles = filtered_articles.includes(:book).order(published_at: :desc).limit(limit)
    render json: @articles
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Not Found' }, status: :not_found
  end

  def show
    @article = Article.find(params[:id])
    render json: @article
  end

  private

  def filtered_articles
    if params[:book_slug].present?
      book = Book.find_by(slug: params[:book_slug])
      return book.articles.published if book.present?
    end

    if params[:author].present?
      user = User.find_by!(email_address: params[:author])
      books = user.books.published
      return Article.where(book: books).published if books.present?
    end

    Article.published
  end

  def limit
    _limit = params[:limit].to_i
    _limit.between?(1, MAX_LIMIT) ? limit : MAX_LIMIT
  end
end
