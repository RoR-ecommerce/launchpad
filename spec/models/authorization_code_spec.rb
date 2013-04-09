require 'spec_helper'

describe AuthorizationCode do
  it 'creates successfully' do
    expect {
      FactoryGirl.create(:authorization_code)
    }.not_to raise_error(ActiveRecord::RecordInvalid)
  end

  describe 'validates' do
    it 'presence of #client_id' do
      expect(AuthorizationCode.new).to have(1).error_on(:client_id)
    end

    it 'presence of #client_secret' do
      expect(AuthorizationCode.new).to have(1).error_on(:client_secret)
    end

    it 'presence of #user_id' do
      expect(AuthorizationCode.new).to have(1).error_on(:user_id)
    end

    it 'presence of #access_token' do
      expect(AuthorizationCode.new).to have(1).error_on(:access_token)
    end

    it 'uniqueness of #code' do
      SecureRandom.stub(:hex).and_return('abc')
      FactoryGirl.create(:authorization_code)
      expect(AuthorizationCode.new).to have(1).error_on(:code)
    end
  end

  describe 'on create' do
    it 'sets #code' do
      SecureRandom.stub(:hex).and_return('a')
      auth_code = AuthorizationCode.new
      auth_code.valid?
      expect(auth_code.code).to eq('a')
    end

    it 'sets #code_expires_at' do
      auth_code = AuthorizationCode.new
      auth_code.valid?
      expect(auth_code.code_expires_at).to be_within(2.minutes).of(Time.current)
    end
  end

  describe 'on update' do
    it 'does not change #code' do
      auth_code = FactoryGirl.create(:authorization_code)
      code = auth_code.code
      auth_code.update_attributes(code_expires_at: Time.current)

      expect(code).to eq(auth_code.code)
    end
  end

  describe 'scopes' do
    it '::expired' do
      auth_code = FactoryGirl.create(:authorization_code)
      auth_code.update_column(:code_expires_at, 1.year.ago)
      expect(AuthorizationCode.expired.first.id).to eq(auth_code.id)
    end

    it '::not_expired' do
      auth_code = FactoryGirl.create(:authorization_code)
      expect(AuthorizationCode.not_expired.first.id).to eq(auth_code.id)
    end

    it '::by_client_and_code' do
      auth_code = FactoryGirl.create(:authorization_code)
      expect(AuthorizationCode.by_client_and_code(
        auth_code.client_id,
        auth_code.client_secret,
        auth_code.code).first.id).to eq(auth_code.id)
    end
  end

  describe 'class methods' do
    it '::authorize' do
      auth_code = FactoryGirl.create(:authorization_code)
      expect(AuthorizationCode.authorize(
        auth_code.client_id,
        auth_code.client_secret,
        auth_code.code).id).to eq(auth_code.id)
    end

    it '::cleanup!' do
      auth_code = FactoryGirl.create(:authorization_code)
      auth_code.update_column(:code_expires_at, 1.year.ago)
      expect { AuthorizationCode.cleanup! }.to \
        change{ AuthorizationCode.count }.from(1).to(0)
    end
  end
end
