class UriMatcher
  attr_reader :uri

  def initialize(uri)
    @uri = uri
  end

  def host
    URI.parse(uri).host
  rescue URI::InvalidURIError
    nil
  end

  def port
    URI.parse(uri).port
  rescue URI::InvalidURIError
    nil
  end

  def eql?(other)
    host == other.host && port == other.port
  end
end
