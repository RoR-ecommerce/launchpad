Airbrake.configure do |config|
  config.api_key = ENV['AIRBRAKE_API_KEY']
  config.development_environments = %w(development test)
  config.rescue_rake_exceptions = true

  Launchpad::Application.config.filter_parameters.each do |param|
    config.params_filters << param.to_s
  end
end
