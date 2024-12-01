class AddDisplayNameToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :display_name, :string, null: false
  end
end
