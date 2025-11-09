class CreatePosts < ActiveRecord::Migration[8.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :category
      t.boolean :published
      t.references :user, null: false, foreign_key: true
      t.string :slug

      t.timestamps
    end
    add_index :posts, :slug, unique: true
  end
end
