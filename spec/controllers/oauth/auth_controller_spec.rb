require 'spec_helper'

describe Oauth::AuthController do
  describe 'GET auth' do
    before do
      sign_in(FactoryGirl.create(:user))
    end

    it 'redirects back to app' do
      app = double(client_id: 1, client_secret: 'secret', redirect_uri: 'http://google.com')
      App.should_receive(:authorize!).and_return(app)

      auth_code = double(code: 'secret_code')
      AuthorizationCreator.any_instance.should_receive(:create!).and_return(auth_code)

      get :auth, client_id: 1, redirect_uri: 'http://google.com/auth', state: 'secret_state'
      expect(response).to redirect_to('http://google.com/auth?code=secret_code&response_type=code&state=secret_state')
    end

    it 'does TBD when app is not found' do
      pending
    end
  end
end
