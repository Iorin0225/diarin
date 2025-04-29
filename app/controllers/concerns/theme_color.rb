module ThemeColor
  extend ActiveSupport::Concern

  included do
    helper_method :theme_color
  end

  private
    def theme_color
      @book&.color || @article&.book&.color || "auto"
    end
end
