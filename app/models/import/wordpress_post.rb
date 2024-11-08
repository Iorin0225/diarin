module Import
  class WordpressPost
    attr_accessor :id, :title, :content, :published_at, :original_url, :status, :post_type, :description, :xml_item

    def initialize(xml_item)
      @xml_item = xml_item
      load_attributes
    end

    def load_attributes
      @id = xml_item.elements['wp:post_id'].text
      @title = xml_item.elements['title'].text
      @description = xml_item.elements['description'].text
      @content = xml_item.elements['content:encoded'].text
      @published_at = xml_item.elements['pubDate'].text
      @original_url = xml_item.elements['link'].text
      @status = xml_item.elements['wp:status'].text
      @post_type = xml_item.elements['wp:post_type'].text
    end

    def put_raw_xml_item
      xml_item.elements.each do |element|
        puts "#{element.name}: #{element.text}"
      end
    end

  end
end
