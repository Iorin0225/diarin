module ArticlesHelper
  def body_with_pre_wrap(article)
    safe_html = sanitize(body_with_embedding(article), tags: %w(blockquote img a script), attributes: %w(class href src charset async))

    content_tag :span, safe_html, style: 'white-space: pre-wrap;'
  end

  def body_with_embedding(article)
    body_html = article.body
    twitter_urls = body_html.scan(/https:\/\/twitter.com\/\w+\/status\/\d+/)
    body_html = twitter_urls.inject(body_html) do |html, url|
      html.gsub(url, twitter_embed(url))
    end
  end

  def twitter_embed(url)
    embed_body = content_tag :blockquote, class: 'twitter-tweet' do
      content_tag(:a, '', href: url)
    end
    embed_body + content_tag(:script, '', src: 'https://platform.twitter.com/widgets.js', charset: 'utf-8', async: true)
  end

  def debug_id(article)
    return unless Rails.env.development? && article.imported_id.present?

    content_tag :span, "ID: #{article.imported_id}", style: 'margin-left: .5rem;'
  end
end
