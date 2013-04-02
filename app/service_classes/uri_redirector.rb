class UriRedirector
  attr_reader :safe_uri, :unsafe_uri

  def initialize(safe_uri, unsafe_uri)
    @safe_uri   = UriMatcher.new(safe_uri)
    @unsafe_uri = UriMatcher.new(unsafe_uri)
  end

  def uri(**fragments)
    UriBuilder.new(base_uri, **fragments).build
  end

  def base_uri
    return safe_uri.uri unless unsafe_uri.uri

    match? ? unsafe_uri.uri : safe_uri.uri
  end

  protected

  def match?
    safe_uri.eql?(unsafe_uri)
  end
end
