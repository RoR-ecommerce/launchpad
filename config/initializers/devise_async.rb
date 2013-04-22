Devise::Async.setup do |config|
  config.backend = :sidekiq
  config.enabled = false if Rails.env.test?
end
