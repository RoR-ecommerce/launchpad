require 'spec_helper'

describe Authorization do
  describe 'validations with missing attributes' do
    it 'fails with no #client_id' do
      expect(Authorization.new).to have(1).error_on(:client_id)
    end

    it 'fails with no #user_id' do
      expect(Authorization.new).to have(1).error_on(:user_id)
    end

    it 'fails on duplicate #client_id for the same #user_id' do
      pending
    end

    it 'fails on duplicate #access_token' do
      pending
    end

    it 'fails on duplicate #code' do
      pending
    end
  end

  describe 'validations with all attributes' do
    it 'is valid' do
      expect(FactoryGirl.create(:authorization)).to be_valid
    end
  end

  describe 'sets required attribute on create' do
    it '#code' do
      SecureRandom.stub(:hex).and_return('a')
      authorization = Authorization.new
      authorization.valid?
      expect(authorization.code).to eq('a')
    end

    it '#code_expires_at' do
      authorization = Authorization.new
      authorization.valid?
      expect(authorization.code_expires_at).to be_within(2.minutes).of(Time.zone.now)
    end

    it 'does not set required attributes on update' do
      authorization = FactoryGirl.create(:authorization)
      code = authorization.code
      authorization.update_attributes(client_id: 2)

      expect(code).to eq(authorization.code)
    end
  end

  describe '#find_secretly' do
    it 'finds last valid authorization' do
      pending
    end
  end
end
