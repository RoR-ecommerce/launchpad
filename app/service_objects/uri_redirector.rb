class UriRedirector
  def initialize(our_uri, their_uri)
    @our_uri   = UriMatcher.new(our_uri)
    @their_uri = UriMatcher.new(their_uri)
  end

  def redirect_uri
    if @their_uri
      match? ? @their_uri.redirect_uri : @our_uri.redirect_uri
    else
      @our_uri.redirect_uri
    end
  end

  private

  def match?
    @our_uri.eql?(@their_uri)
  end
end
