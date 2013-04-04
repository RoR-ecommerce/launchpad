FactoryGirl.define do
  factory :authorization_code do
    user
    access_token { user.access_token }

    before(:create) do |auth_code|
      client = FactoryGirl.create(:client)
      auth_code.client_id     = client.client_id
      auth_code.client_secret = client.client_secret
    end
  end
end
