class CreateArticles < ActiveRecord::Migration[8.0]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.string :status, null: false

      t.datetime :published_at

      t.timestamps
    end
  end
end
