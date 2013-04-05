class JsonParserExceptions < ActionDispatch::ParamsParser
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
