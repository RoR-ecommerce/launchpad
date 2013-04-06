require 'spec_helper'

describe Oauth::UserController do
  describe 'GET user' do
    it 'returns error message if not authorized' do
      User.should_receive(:authorize_with_token).and_return(false)

      get :user
      expect(response.code).to eq('401')
      expect(response.body).to eq({ message: 'Unauthorized Request' }.to_json)
    end

    it 'returns user' do
      user = stub_model(User)
      User.should_receive(:authorize_with_token).and_return(user)

      get :user
      expect(response.code).to eq('200')
      expect(response.body).to eq(user.to_json)
    end
  end
end
