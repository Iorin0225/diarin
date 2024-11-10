module ArticlesHelper
  def body_with_pre_wrap(article)
    safe_html = sanitize(article.body, tags: %w(img a), attributes: %w(href src))

    content_tag :span, safe_html, style: 'white-space: pre-wrap;'
  end

  def debug_id(article)
    return unless Rails.env.development? && article.imported_id.present?

    content_tag :span, "ID: #{article.imported_id}", style: 'margin-left: .5rem;'
  end
end
