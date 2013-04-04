namespace :maintenance do
  desc 'Cleanup expired authorization codes'
  task :cleanup_codes => :environment do
    AuthorizationCode.cleanup!
  end
end
