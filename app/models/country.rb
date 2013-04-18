class Country < ActiveRecord::Base
  has_many :users, inverse_of: :country

  validates :name, :iso_name, :alpha2, :alpha3, :numcode,
    presence: true

  default_scope -> { order(:name) }

  class << self
    # Returns all countries sorted by name, but preferred on top.
    #
    def all_sorted
      Country::PreferredSorter.new(all).sort
    end

    # Cache all sorted countries forever, expire manually if needed.
    #
    def all_sorted_and_cached
      Rails.cache.fetch('app/models/country#all_sorted_and_cached') do
        Country.all_sorted
      end
    end

    # Delete all caches with no auto expiration.
    #
    def expire_cache!
      Rails.cache.delete('app/models/country#all_sorted_and_cached')
    end
  end
end
