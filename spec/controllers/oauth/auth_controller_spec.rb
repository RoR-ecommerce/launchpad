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

    it 'returns page not found if app is not found' do
      expect {
        get :auth
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
