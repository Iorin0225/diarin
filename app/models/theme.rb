class Theme
  include ActiveModel::Model

  SLUGS = %w[default casual modern novel]

  attr_reader :slug

  def initialize(slug)
    @slug = slug
  end
end
