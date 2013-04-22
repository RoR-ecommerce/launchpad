if Rails.env.development?
  App.create! do |app|
    app.name         = 'Tracker'
    app.uri          = 'http://localhost:3000'
    app.redirect_uri = 'http://localhost:3000/users/auth/ufc/callback'
  end
end

# In order to bootstrap database with list of Apps, first thing you need to do
# is to make sure that Heroku has appropriate environment variable set.
#
# ENV['SEEDS_ENVIRONMENT'] = 'staging'    # for stating
# ENV['SEEDS_ENVIRONMENT'] = 'production' # for production
#
# To set new environment variable run
#
# heroku config:set SEEDS_ENVIRONMENT=staging --app ufc-launchpad-staging
# heroku config:set SEEDS_ENVIRONMENT=production --app ufc-launchpad

if Rails.env.production? && ENV['SEEDS_ENVIRONMENT'] == 'staging'
  App.where(name: 'Tracker').first_or_create! do |app|
    app.uri          = 'http://tracker.rubydj.com'
    app.redirect_uri = 'https://tracker.rubydj.com/users/auth/ufc/callback'
  end

  App.where(name: 'Store US').first_or_create! do |app|
    app.uri          = 'http://rubydj.com'
    app.redirect_uri = 'https://rubydj.com/auth/ufc/callback'
  end

  # TODO Store CA needs to be added.
end

if Rails.env.production? && ENV['SEEDS_ENVIRONMENT'] == 'production'
  App.where(name: 'Tracker').first_or_create! do |app|
    app.uri          = 'http://tracker.ufcfit.com'
    app.redirect_uri = 'https://tracker.ufcfit.com/users/auth/ufc/callback'
  end

  App.where(name: 'Store US').first_or_create! do |app|
    app.uri          = 'http://ufcfit.com'
    app.redirect_uri = 'https://ufcfit.com/auth/ufc/callback'
  end

  App.where(name: 'Store CA').first_or_create! do |app|
    app.uri          = 'http://ufcfit.ca'
    app.redirect_uri = 'https://ufcfit.ca/users/auth/ufc/callback'
  end
end
