namespace :data do
  desc "Migrate category strings to Category records"
  task migrate_categories: :environment do
    # Get all unique category strings from existing posts
    categories = Post.where.not(category: nil).pluck(:category).uniq.compact

    # Create Category records for each unique category string
    categories.each do |cat_name|
      next if cat_name.blank?
      category = Category.find_or_create_by!(name: cat_name)

      # Update posts with this category string to use the category_id
      Post.where(category: cat_name).update_all(category_id: category.id)
      puts "Migrated '#{cat_name}' -> Category ##{category.id}"
    end

    puts "\nMigration complete!"
    puts "Total categories: #{Category.count}"
    Category.all.each { |c| puts "  - #{c.name} (#{c.posts.count} posts)" }
  end
end
