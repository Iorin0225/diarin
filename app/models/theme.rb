class Theme
  include ActiveModel::Model

  SLUGS = %w[default casual modern]

  attr_reader :slug

  def initialize(slug)
    @slug = slug
  end
end
