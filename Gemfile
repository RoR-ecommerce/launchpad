source 'https://rubygems.org'
ruby   '2.0.0'

gem 'unicorn',              '4.6.2'
gem 'foreman',              '0.63.0'
gem 'dalli',                '2.6.2'
gem 'sidekiq',              '2.10.1'

# Sidekiq web dependencies.
gem 'slim',               '~> 1.3.8', require: false
gem 'sinatra',            '~> 1.3.0', require: false

# kgio gem is Unicorn dependecy, it also can speed up Memcached I/O operations,
# it is defined here explicitly in order not to loose it incase Unicorn drop
# this dependency in the future.
gem 'kgio',                 '2.8.0'

gem 'rails',                '3.2.13'
gem 'jquery-rails',         '2.2.1'
gem 'strong_parameters',    '0.2.0'
gem 'dynamic_form',         '1.1.4'

gem 'pg',                   '0.15.1'
gem 'postgres_ext',         '0.3.0' # won't be needed on Rails 4

gem 'devise',               '2.2.3'
gem 'devise-async',         '0.7.0'
gem 'secure_headers',       '0.4.1' # might not be needed on Rails 4

gem 'airbrake',             '3.1.11'
gem 'newrelic_rpm',         '3.6.0.83'

group :development, :test do
  gem 'rspec-rails',        '~> 2.13.0'
  gem 'factory_girl_rails', '~> 4.2.1'
end

group :test do
  gem 'database_cleaner',   '~> 0.9.1'
  gem 'capybara',           '~> 2.1.0'
  gem 'poltergeist',        '~> 1.2.0'
  gem 'ffaker',             '~> 1.15.0'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',         '3.2.6'
  gem 'coffee-rails',       '3.2.2'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer',       '0.11.4', platforms: :ruby

  gem 'uglifier',           '2.0.1'
end
