class SpoofingMatcher
  def initialize(referrer, referree)
    @referrer = UriMatcher.new(referrer)
    @referree = UriMatcher.new(referree)
  end

  def match?
    @referree.eql?(@referrer)
  end
end
