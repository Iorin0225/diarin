class ArticlesController < ApplicationController
  allow_unauthenticated_access only: [:index, :show]

  def index
  end

  def show
    @article = Article.find(params[:id])
    redirect_to books_path if @article.nil?

    @book = @article.book
  end

  def new
    book = Book.find_by(slug: params[:book_slug])
    redirect_to root_path if book.nil?
    @article = book.articles.build
    @books = Current.user.books
  end

  def create
    article = Article.new(article_params)
    if article.save
      redirect_to article_path(article)
    else
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
    redirect_to root_path if @article.nil?

    @books = Current.user.books
  end

  def update
    article = Article.find(params[:id])
    redirect_to root_path if article.nil?

    if article.update(article_params)
      redirect_to article_path(article)
    else
      render :edit
    end
  end

  def destroy
    article = Article.find(params[:id])
    redirect_to root_path if article.nil?

    book = article.book
    article.update(status: :deleted)

    redirect_to book_path(book)
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :status, :published_at, :book_id)
    end
end
