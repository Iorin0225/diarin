xml.instruct! :xml, version: "1.0"
xml.rss version: "2.0" do
  xml.channel do
    xml.title @book.title
    xml.description @book.description
    xml.link book_url(@book)

    @articles.each do |article|
      xml.item do
        xml.title article.title
        xml.description body_with_pre_wrap(article)
        xml.pubDate article.published_at.rfc2822
        xml.link article_url(article, book_slug: @book.slug)
        xml.guid article_url(article, book_slug: @book.slug), isPermaLink: "true"
      end
    end
  end
end
