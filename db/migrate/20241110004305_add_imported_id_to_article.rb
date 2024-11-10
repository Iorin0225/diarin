class AddImportedIdToArticle < ActiveRecord::Migration[8.0]
  def change
    add_column :articles, :imported_id, :integer
    add_index :articles, :imported_id
  end
end
