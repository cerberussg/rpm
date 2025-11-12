class AddPublishedAtToPosts < ActiveRecord::Migration[8.1]
  def change
    add_column :posts, :published_at, :datetime

    # Backfill existing published posts with their created_at date
    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE posts
          SET published_at = created_at
          WHERE published = true AND published_at IS NULL
        SQL
      end
    end
  end
end
