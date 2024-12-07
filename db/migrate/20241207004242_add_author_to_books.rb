class AddAuthorToBooks < ActiveRecord::Migration[8.0]
  def change
    add_column :books, :author_user_id, :integer
    add_foreign_key :books, :users, column: :author_user_id
  end
end
