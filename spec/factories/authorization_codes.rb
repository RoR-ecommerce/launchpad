FactoryGirl.define do
  factory :authorization_code do
    user
    access_token { user.access_token }

    before(:create) do |auth_code|
      client = FactoryGirl.create(:client)
      auth_code.app_id     = client.app_id
      auth_code.app_secret = client.app_secret
    end
  end
end
