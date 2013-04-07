require 'spec_helper'

describe Oauth::AuthController do
  describe 'GET auth' do
    before do
      sign_in(FactoryGirl.create(:user))
    end

    let(:app) { double(client_id: 1, client_secret: 'secret', redirect_uri: 'http://google.com') }
    let(:auth_code) { double(code: 'secret_code') }

    it 'redirects back to app' do
      App.should_receive(:authorize!).and_return(app)
      AuthorizationCreator.any_instance.should_receive(:create!).and_return(auth_code)

      get :auth, client_id: 1, redirect_uri: 'http://google.com/auth', state: 'secret_state'
      expect(response).to redirect_to('http://google.com/auth?code=secret_code&response_type=code&state=secret_state')
    end

    it 'returns error message if app is not found' do
      App.should_receive(:authorize!).and_return(nil)

      get :auth
      expect(response.code).to eq('401')
      expect(response.body).to eq({ message: 'Unauthorized Request' }.to_json)
    end
  end
end
