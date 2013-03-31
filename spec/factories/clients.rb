FactoryGirl.define do
  factory :client do
    name         { Faker::Lorem.word }
    uri          { Faker::Internet.http_url }
    redirect_uri { uri + '/callback' }
  end
end
