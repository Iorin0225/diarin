module Import
  class WordpressBlog
    attr_accessor :title, :description, :slug, :published_at, :xml_item

    def initialize(xml_document)
      @xml_item = xml_document.elements['rss/channel']
      load_attributes
    end

    def load_attributes
      self.title = xml_item.elements['title'].text
      self.slug = xml_item.elements['link'].text.split('/').last
      self.description = xml_item.elements['description'].text
      self.published_at = Time.parse(xml_item.elements['pubDate'].text)
    end
  end
end
