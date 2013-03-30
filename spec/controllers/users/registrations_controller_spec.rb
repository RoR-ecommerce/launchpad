require 'spec_helper'

describe Users::RegistrationsController do
  describe 'with permitted attributes defined' do
    before(:each) do
      request.env['devise.mapping'] = Devise.mappings[:user]
      User.any_instance.stub(:save).and_return(true)
    end

    it 'successfully creates user record' do
      post :create, user: {}
      expect { response }.not_to raise_error(ActionController::UnpermittedParameters)
    end

    it 'send :bad_request back when required param is missing' do
      post :create
      expect(response).to be_bad_request
    end

    it 'raises an error with unpermitted keys in params' do
      expect {
        post :create, user: { encrypted_password: 'ha!' }
      }.to raise_error(ActionController::UnpermittedParameters)
    end
  end
end
