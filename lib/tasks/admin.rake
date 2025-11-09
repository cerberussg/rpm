namespace :admin do
  desc "Make a user an admin by email address"
  task :create, [:email] => :environment do |t, args|
    if args[:email].blank?
      puts "Usage: rails admin:create[user@example.com]"
      exit 1
    end

    user = User.find_by(email_address: args[:email])

    if user.nil?
      puts "Error: User with email '#{args[:email]}' not found."
      puts "Please make sure the user has signed up first."
      exit 1
    end

    if user.admin?
      puts "User '#{args[:email]}' is already an admin."
    else
      user.update!(admin: true)
      puts "Success! User '#{args[:email]}' is now an admin."
    end
  end

  desc "Remove admin privileges from a user by email address"
  task :remove, [:email] => :environment do |t, args|
    if args[:email].blank?
      puts "Usage: rails admin:remove[user@example.com]"
      exit 1
    end

    user = User.find_by(email_address: args[:email])

    if user.nil?
      puts "Error: User with email '#{args[:email]}' not found."
      exit 1
    end

    if !user.admin?
      puts "User '#{args[:email]}' is not an admin."
    else
      user.update!(admin: false)
      puts "Success! Admin privileges removed from '#{args[:email]}'."
    end
  end

  desc "List all admin users"
  task list: :environment do
    admins = User.where(admin: true)

    if admins.any?
      puts "Admin users:"
      admins.each do |admin|
        puts "  - #{admin.email_address}"
      end
    else
      puts "No admin users found."
    end
  end
end
