module ArticlesHelper
  def body_with_pre_wrap(article)
    safe_html = sanitize(body_with_embedding(article), tags: %w(blockquote img a script iframe), attributes: %w(class href src charset async data-instgrm-permalink))

    content_tag :span, safe_html, style: 'white-space: pre-wrap;'
  end

  def body_with_embedding(article)
    body_html = article.body

    twitter_urls = body_html.scan(/https:\/\/twitter.com\/\w+\/status\/\d+/)
    body_html = twitter_urls.inject(body_html) do |html, url|
      html.gsub(url, twitter_embed(url))
    end

    instagram_urls = body_html.scan(/https:\/\/www.instagram.com\/p\/.+/)
    body_html = instagram_urls.inject(body_html) do |html, url|
      html.gsub(url, instagram_embed(url))
    end

    instagram_reel_urls = body_html.scan(/https:\/\/www.instagram.com\/reel\/.+/)
    body_html = instagram_reel_urls.inject(body_html) do |html, url|
      html.gsub(url, instagram_reel_embed(url))
    end

    youtube_urls = body_html.scan(/https:\/\/www.youtube.com\/watch\?v=[\w-]+/)
    youtube_urls += body_html.scan(/https:\/\/youtu.be\/[\w-]+/)
    body_html = youtube_urls.inject(body_html) do |html, url|
      html.gsub(url, youtube_embed(url))
    end
  end

  def youtube_embed(url)
    if url.include?('youtu.be')
      video_id = url.split('/').last
    else
      video_id = url.split('v=').last
    end
    embed_url = "https://www.youtube.com/embed/#{video_id}"
    content_tag :iframe, '', src: embed_url
  end

  def instagram_reel_embed(url)
    embed_body = content_tag :blockquote, class: 'instagram-media', 'data-instgrm-permalink': url do
      content_tag(:a, '', href: url)
    end
    embed_body + content_tag(:script, '', src: 'https://www.instagram.com/embed.js', charset: 'utf-8', async: true)
  end

  def instagram_embed(url)
    embed_body = content_tag :blockquote, class: 'instagram-media', 'data-instgrm-permalink': url do
      content_tag(:a, '', href: url)
    end
    embed_body + content_tag(:script, '', src: 'https://www.instagram.com/embed.js', charset: 'utf-8', async: true)
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
