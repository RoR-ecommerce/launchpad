require 'spec_helper'

describe AuthorizationCreator do
  it 'creates authorization code' do
    user = stub_model(User, access_token: '123')
    app  = stub_model(App, client_id: 1, client_secret: 'secret')

    expect{
      AuthorizationCreator.new(user, app).create!
    }.to change{ AuthorizationCode.count }.from(0).to(1)
  end
end
