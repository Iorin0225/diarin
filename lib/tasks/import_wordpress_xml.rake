namespace :import_wordpress_xml do
  desc "Import Wordpress XML in lib "
  task import: :environment do
    require 'rexml/document'

    puts 'Importing Wordpress XML'

    file_path = Rails.root.join('lib', 'import_files', 'wordpress.xml')
    xml_data = File.read(file_path)
    document = REXML::Document.new(xml_data)

    blog = Import::WordpressBlog.new(document)

    pp "Start Importing #{blog.title}"

    book = Book.find_or_create_by!(title: blog.title) do |tmp_book|
      tmp_book.description = blog.description
      tmp_book.slug = blog.slug
      tmp_book.published_at = blog.published_at
      tmp_book.status = 'published'
    end

    blog_posts = []
    document.elements.each('rss/channel/item') do |xml_item|
      blog_post = Import::WordpressPost.new(xml_item)
      blog_posts << blog_post

      # show progress
      print "\r#{blog_posts.count} posts loaded"
    end
    pp  ""

    insert_bulk_data = []
    blog_posts.each do |blog_post|
      insert_bulk_data << {
        book_id: book.id,
        id: blog_post.id,
        title: blog_post.title,
        body: blog_post.content,
        status: blog_post.status,
        published_at: blog_post.published_at
      }
    end

    Article.delete_all
    Article.insert_all(insert_bulk_data)
    pp 'done'

  end

  desc "Download Images"
  task download_images: :environment do
    Book.all.find_each do |book|
      book.articles.where('body LIKE %https://%')
    end
  end
end


# book = Book.take
# urls = []
# book.articles.find_each do |article|
#   image_tags = article.body.scan(/<img[^>]+src="([^">]+)"/)
#   urls += image_tags.map { |tag| tag[0] }
# end

# puts urls

# instagram_urls = []
# book.articles.find_each do |article|
#   instagram_tags = article.body.scan(/(https:\/\/www\.instagram\.com\/p\/([^\/]+))/)
#   instagram_urls += instagram_tags.map { |tag| tag[0] }
# end

# puts instagram_urls

# twitter_urls = []
# book.articles.find_each do |article|
#   twitter_tags = article.body.scan(/(https:\/\/twitter\.com\/(.+))/)

#   twitter_urls += twitter_tags.map { |tag| tag[0] }
# end

# puts twitter_urls
