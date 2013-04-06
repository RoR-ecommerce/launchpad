FactoryGirl.define do
  factory :authorization_code do
    user
    access_token { user.access_token }

    before(:create) do |auth_code|
      app = FactoryGirl.create(:app)
      auth_code.client_id     = app.client_id
      auth_code.client_secret = app.client_secret
    end
  end
end
