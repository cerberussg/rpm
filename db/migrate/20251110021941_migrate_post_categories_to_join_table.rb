class MigratePostCategoriesToJoinTable < ActiveRecord::Migration[8.1]
  def up
    # Migrate existing post category associations to join table
    Post.where.not(category_id: nil).find_each do |post|
      execute <<-SQL
        INSERT INTO categories_posts (category_id, post_id)
        VALUES (#{post.category_id}, #{post.id})
      SQL
    end

    # Remove the old category_id column from posts
    remove_column :posts, :category_id
  end

  def down
    # Add back the category_id column
    add_reference :posts, :category, foreign_key: true

    # Migrate first category from join table back to category_id
    execute <<-SQL
      UPDATE posts
      SET category_id = (
        SELECT category_id
        FROM categories_posts
        WHERE categories_posts.post_id = posts.id
        LIMIT 1
      )
    SQL
  end
end
