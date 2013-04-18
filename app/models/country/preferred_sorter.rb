class Country::PreferredSorter
  PREFERRED = %w(USA GBR CAN AUS)

  def initialize(collection)
    @collection = collection
  end

  def sort
    @sort ||= @collection.sort_by do |c|
      PREFERRED.include?(c.alpha3) ? \
        PREFERRED.index(c.alpha3) : @collection.index(c) + PREFERRED.size
    end
  end
end
