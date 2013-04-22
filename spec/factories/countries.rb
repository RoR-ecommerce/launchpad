FactoryGirl.define do
  factory :country_us, class: Country do
    name     'United States'
    iso_name 'UNITED STATES'
    alpha2   'US'
    alpha3   'USA'
    numcode  840
  end

  factory :country_ca, class: Country do
    name     'Canada'
    iso_name 'CANADA'
    alpha2   'CA'
    alpha3   'CAN'
    numcode  124
  end

  factory :country_et, class: Country do
    name     'Ethiopia'
    iso_name 'ETHIOPIA'
    alpha2   'ET'
    alpha3   'ETH'
    numcode  231
  end

  factory :country_zw, class: Country do
    name     'Zimbabwe'
    iso_name 'ZIMBABWE'
    alpha2   'ZW'
    alpha3   'ZWE'
    numcode  716
  end
end
