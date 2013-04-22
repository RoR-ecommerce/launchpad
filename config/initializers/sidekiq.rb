require 'sidekiq/web'

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDISCLOUD_URL'], namespace: 'launchpad' } \
    if ENV['REDISCLOUD_URL']

  database_url = ENV['DATABASE_URL']
  if database_url
    ENV['DATABASE_URL'] = "#{database_url}?pool=25"
    ActiveRecord::Base.establish_connection
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDISCLOUD_URL'], namespace: 'launchpad' } \
    if ENV['REDISCLOUD_URL']
end

Sidekiq::Web.use(Rack::Auth::Basic) do |username, password|
  username == ENV['SIDEKIQ_USER'] && password == ENV['SIDEKIQ_PASSWORD']
end unless Rails.env.development?
