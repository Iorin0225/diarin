module ArticlesHelper
  def body_with_pre_wrap(article)
    safe_html = sanitize(article.body, tags: %w(img a), attributes: %w(href src))
    content_tag :span, safe_html, style: 'white-space: pre-wrap;'
  end
end
