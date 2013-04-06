require 'spec_helper'

describe Oauth::TokenController do
  describe 'POST create' do
    it 'returns error message if not authorized' do
      AuthorizationCode.should_receive(:authorize).and_return(false)

      post :create
      expect(response.code).to eq('401')
      expect(response.body).to eq({ message: 'Unauthorized Request' }.to_json)
    end

    it 'returns access_token' do
      auth_code = double(access_token: 'abc')
      AuthorizationCode.should_receive(:authorize).and_return(auth_code)

      post :create
      expect(response.code).to eq('200')
      expect(response.body).to eq({ access_token: 'abc', token_type: 'bearer' }.to_json)
    end
  end
end
