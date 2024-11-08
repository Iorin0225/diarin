class AddBookIdToArticles < ActiveRecord::Migration[8.0]
  def change
    add_column :articles, :book_id, :integer, null: false

    add_index :articles, :book_id
  end
end
