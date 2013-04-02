require 'spec_helper'

describe Client do
  describe 'validations with missing attributes' do
    it 'fails with no #name' do
      expect(Client.new).to have(1).error_on(:name)
    end

    it 'fails with no #uri' do
      expect(Client.new).to have(1).error_on(:uri)
    end

    it 'fails with no #redirect_uri' do
      expect(Client.new).to have(1).error_on(:redirect_uri)
    end

    it 'fails on duplicate #client_id' do
      pending
    end

    it 'fails on duplicate #client_secret' do
      pending
    end

    it 'fails on duplicate #uri' do
      pending
    end

    it 'fails on duplicate #redirect_uri' do
      pending
    end
  end

  describe 'validations with all attributes' do
    it 'is valid' do
      expect(FactoryGirl.build(:client)).to be_valid
    end
  end

  describe 'sets required attribute on create' do
    it '#client_id' do
      SecureRandom.stub(:hex).and_return('a')
      client = Client.new
      client.valid?
      expect(client.client_id).to eq('a')
    end

    it '#client_secret' do
      SecureRandom.stub(:hex).and_return('b')
      client = Client.new
      client.valid?
      expect(client.client_secret).to eq('b')
    end

    it '#access_token' do
      pending
    end

    it 'does not set required attributes on update' do
      client = FactoryGirl.create(:client)
      client_id = client.client_id
      client_secret = client.client_secret
      client.update_attributes(name: 'foo')

      expect(client_id).to eq(client.client_id)
      expect(client_secret).to eq(client.client_secret)
    end
  end

  describe '#find_one!' do
    it 'finds client by #client_id and #client_secret' do
      pending
    end

    it 'raises RecordNotFound if client is not found' do
      pending
    end
  end

  describe '#find_one_with_secret!' do
    it 'finds client by #client_id and #client_secret' do
      pending
    end

    it 'raises RecordNotFound if client is not found' do
      pending
    end
  end
end
