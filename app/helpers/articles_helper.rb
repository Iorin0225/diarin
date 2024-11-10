module ArticlesHelper
  def body_with_pre_wrap(article)
    content_tag :span, article.body, style: 'white-space: pre-wrap;'
  end
end
