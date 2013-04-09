module Middlewares
  # Rails throws `MultiJson::LoadError` on invalid JSON too early in the
  # process so there is no way to intercept it using `rescue_from`, thus adding
  # small middleware that wraps `ActionDispatch::ParamsParser` and rescues
  # `MultiJson::LoadError`.
  #
  class ParamsParser < ActionDispatch::ParamsParser
    def call(env)
      super
    rescue MultiJson::LoadError
      [
        400,
        { 'Content-Type' => 'application/json; charset=utf-8' },
        [ { message: 'Error parsing JSON' }.to_json ]
      ]
    end
  end
end
