class UriBuilder
  attr_reader :uri, :fragments

  def initialize(uri, **fragments)
    @uri       = uri
    @fragments = fragments
  end

  def build
    return uri unless query_string

    if uri =~ /\?/
      uri << "&#{query_string}"
    else
      uri << "?#{query_string}"
    end
  end

  private

  def query_string
    @query_string ||= fragments.to_param
  end
end
