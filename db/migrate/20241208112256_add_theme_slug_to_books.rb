class AddThemeSlugToBooks < ActiveRecord::Migration[8.0]
  def change
    add_column :books, :theme_slug, :string, null: false, default: 'default'
  end
end
