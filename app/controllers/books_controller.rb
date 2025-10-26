class BooksController < ApplicationController
  allow_unauthenticated_access only: [:index, :show, :rss]

  def index
    @books = Book.published
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.author = Current.user
    if @book.save
      redirect_to book_path(@book.slug)
    else
      flash.now[:alert] = @book.errors.full_messages.join("\n")
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @book = Book.find_by(slug: params[:slug])
    redirect_to books_path if @book.blank?

    handle_wordpress_url if wordpress_id_param.present?

    @articles = @book.articles.published.order(published_at: :desc).limit(100)

    year = params[:year].to_i if params[:year].present?
    month = params[:month].to_i if params[:month].present?
    @articles = filter_by_year_month(@articles, year, month)

    search_param = params[:search]
    @articles = filter_by_seach_params(@articles, search_param)

    @is_first_view = first_view?
  end

  def edit
    @book = Book.find_by(slug: params[:slug])
  end

  def update
    @book = Book.find_by(slug: params[:slug])
    if @book.update(book_params)
      redirect_to book_path(@book.slug)
    else
      render :edit
    end
  end

  def rss
    @book = Book.find_by(slug: params[:slug])
    # not found instead of redirecting
    head :not_found and return if @book.blank?
    @articles = @book.articles.published.order(published_at: :desc).limit(20)

    respond_to do |format|
      format.rss { render layout: false }
      format.xml { render layout: false }
    end
  end

  private
    def first_view?
      (params.keys - %w[controller action slug]).empty?
    end

    def filter_by_year_month(articles, year, month)
      if year.present? && month.present?
        articles.with_year_month(year, month)
      elsif year.present?
        articles.with_year(year)
      else
        articles
      end
    end

    def filter_by_seach_params(articles, search_param)
      search_keys = search_param.to_s.split(/\s+/)
      search_keys.each do |key|
        articles = articles.search(key)
      end
      articles
    end

    def book_params
      params.require(:book).permit(
        :title,
        :description,
        :slug,
        :theme_slug,
        :first_view_type,
        :color,
        :published_at)
    end

    def wordpress_id_param
      params[:p]
    end

    def handle_wordpress_url
      article = Article.find_by(imported_id: wordpress_id_param, book: @book)

      return if article.blank?
      redirect_to article_path(article)
    end
end
