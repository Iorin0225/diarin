class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.string :slug, null: false

      t.string :status
      t.datetime :published_at

      t.timestamps
    end
  end
end
