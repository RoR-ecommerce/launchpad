require 'spec_helper'

describe Client do
  describe '::validations' do
    it 'with no #name' do
      expect(Client.new).to have(1).error_on(:name)
    end

    it 'with no #uri' do
      expect(Client.new).to have(1).error_on(:uri)
    end

    it 'with no #redirect_uri' do
      expect(Client.new).to have(1).error_on(:redirect_uri)
    end

    it 'with duplicate #client_id' do
      pending
    end

    it 'with duplicate #client_secret' do
      pending
    end

    it 'with duplicate #uri' do
      pending
    end

    it 'with duplicate #redirect_uri' do
      pending
    end

    it 'with valid attributes' do
      expect(FactoryGirl.build(:client)).to be_valid
    end
  end

  describe 'on create' do
    it 'sets #client_id' do
      SecureRandom.stub(:hex).and_return('a')
      client = Client.new
      client.valid?
      expect(client.client_id).to eq('a')
    end

    it 'sets #client_secret' do
      SecureRandom.stub(:hex).and_return('b')
      client = Client.new
      client.valid?
      expect(client.client_secret).to eq('b')
    end
  end

  describe 'on update' do
    it 'does not set #client_id and #client_secret' do
      client = FactoryGirl.create(:client)
      client_id = client.client_id
      client_secret = client.client_secret
      client.update_attributes(name: 'foo')

      expect(client_id).to eq(client.client_id)
      expect(client_secret).to eq(client.client_secret)
    end
  end

  describe '::find!' do
    it 'finds client by #client_id' do
      pending
    end

    it 'raises RecordNotFound if client is not found' do
      pending
    end
  end

  describe '::secure_find!' do
    it 'finds client by #client_id and #client_secret' do
      pending
    end

    it 'raises RecordNotFound if client is not found' do
      pending
    end
  end
end
