require 'sidekiq/web'

Sidekiq.configure_server do |config|
  if ENV['REDISCLOUD_URL']
    config.redis = { url: ENV['REDISCLOUD_URL'], namespace: 'launchpad' }
  end

  database_url = ENV['DATABASE_URL']
  if database_url
    ENV['DATABASE_URL'] = "#{database_url}?pool=25"
    ActiveRecord::Base.establish_connection
  end
end

Sidekiq::Web.use(Rack::Auth::Basic) do |username, password|
  username == ENV['SIDEKIQ_USER'] && password == ENV['SIDEKIQ_PASSWORD']
end unless Rails.env.development?
