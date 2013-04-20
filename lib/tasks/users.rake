namespace :users do
  desc "Import users from UFCFit app"
  task :import => :environment do
    raise "No FIT_DATABASE_URL found" unless ENV['FIT_DATABASE_URL']

    class FitDatabase < ActiveRecord::Base
      self.abstract_class = true
      establish_connection(ENV['FIT_DATABASE_URL'])
    end

    class FitUser < FitDatabase
      self.table_name = "users"
    end

    class LaunchpadUser < User

      private
      def send_welcome_message; end
    end

    puts "\n---> Starting user import..."

    User.transaction do
      User.destroy_all

      puts "Users total to migrate: #{FitUser.count}"

      FitUser.all.each do |user|
        new_user = LaunchpadUser.create(
          first_name:           user.first_name,
          last_name:            user.last_name,
          email:                user.email,
          country:              Country.where(alpha3: 'USA').first,
          password:             SecureRandom.hex(10),
          old_crypted_password: user.crypted_password,
          old_password_salt:    user.password_salt
        )
        user.update_attributes(uid: new_user.uid, provider: 'ufc')
        print "."
      end

      puts "\n\nUsers migrated: #{User.count}"
    end

    puts "\n---> User migration complete!\n\n"
  end
end
