require 'spec_helper'

describe Country::PreferredSorter do
  let!(:no_preferred) do
    [
      FactoryGirl.build(:country_zw),
      FactoryGirl.build(:country_et)
    ]
  end

  let!(:with_preferred) do
    [
      FactoryGirl.build(:country_ca),
      FactoryGirl.build(:country_us),
      FactoryGirl.build(:country_zw),
      FactoryGirl.build(:country_et)
    ]
  end

  it 'keeps order of collection if no preferred' do
    expect(Country::PreferredSorter.new(no_preferred).sort.map(&:name)).to \
      eq(['Zimbabwe', 'Ethiopia'])
  end

  it 'puts preferred countries on top' do
    expect(Country::PreferredSorter.new(with_preferred).sort.map(&:name)).to \
      eq(['United States', 'Canada', 'Zimbabwe', 'Ethiopia'])
  end
end
