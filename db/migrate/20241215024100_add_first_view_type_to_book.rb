class AddFirstViewTypeToBook < ActiveRecord::Migration[8.0]
  def change
    add_column :books, :first_view_type, :string, null: false, default: "list"
  end
end
