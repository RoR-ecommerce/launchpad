require 'spec_helper'

describe Country do
  it 'default scope orders by name' do
    FactoryGirl.create(:country_zw)
    FactoryGirl.create(:country_et)

    expect(Country.all.map(&:name)).to eq(['Ethiopia', 'Zimbabwe'])
  end

  it 'is valid' do
    expect(FactoryGirl.build(:country_us)).to be_valid
  end

  describe 'validates' do
    it 'presense of #name' do
      expect(Country.new).to have(1).error_on(:name)
    end

    it 'presense of #iso_name' do
      expect(Country.new).to have(1).error_on(:iso_name)
    end

    it 'presense of #alpha2' do
      expect(Country.new).to have(1).error_on(:alpha2)
    end

    it 'presense of #alpha3' do
      expect(Country.new).to have(1).error_on(:alpha3)
    end

    it 'presense of #numcode' do
      expect(Country.new).to have(1).error_on(:numcode)
    end
  end

  describe 'class methods' do
    before do
      FactoryGirl.create(:country_us)
      FactoryGirl.create(:country_zw)
    end

    it '::all_sorted returns sorted collection' do
      expect(Country.all_sorted.map(&:name)).to eq(['United States', 'Zimbabwe'])
    end

    it '::all_sorted_and_cached returns sorted and cached collection' do
      Country.expire_cache!
      Country.all_sorted_and_cached
      expect(Rails.cache.fetch('app/models/country#all_sorted_and_cached')).not_to be_nil
    end

    it '::expire_cache! expires cache' do
      Country.all_sorted_and_cached
      Country.expire_cache!
      expect(Rails.cache.fetch('app/models/country#all_sorted_and_cached')).to be_nil
    end
  end
end
