class AddColorToBooks < ActiveRecord::Migration[8.0]
  def change
    add_column :books, :color, :string, null: false, default: "auto"
  end
end
