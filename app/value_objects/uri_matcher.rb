class UriMatcher
  attr_reader :redirect_uri

  def initialize(redirect_uri)
    @redirect_uri = redirect_uri
  end

  def host
    URI.parse(redirect_uri).host
  rescue URI::InvalidURIError
    nil
  end

  def port
    URI.parse(redirect_uri).port
  rescue URI::InvalidURIError
    nil
  end

  def eql?(other)
    host == other.host && port == other.port
  end
end
