require 'spec_helper'

describe Client do
  it 'is valid' do
    expect(FactoryGirl.build(:client)).to be_valid
  end

  describe 'validates' do
    it 'presence of #name' do
      expect(Client.new).to have(1).error_on(:name)
    end

    it 'presence of #uri' do
      expect(Client.new).to have(1).error_on(:uri)
    end

    it 'presence of #redirect_uri' do
      expect(Client.new).to have(1).error_on(:redirect_uri)
    end

    describe 'uniqueness' do
      before(:each) do
        SecureRandom.stub(:hex).and_return('abc')
        FactoryGirl.create(:client)
      end

      let(:client) do
        client = Client.new
        client.valid?
        client
      end

      it 'of #app_id' do
        expect(client).to have(1).error_on(:app_id)
      end

      it 'of #app_secret' do
        expect(client).to have(1).error_on(:app_secret)
      end

      it 'of #uri' do
        expect(client).to have(1).error_on(:uri)
      end

      it 'of #redirect_uri' do
        expect(client).to have(1).error_on(:redirect_uri)
      end
    end
  end

  describe 'on create' do
    it 'sets #app_id' do
      SecureRandom.stub(:hex).and_return('a')
      client = Client.new
      client.valid?
      expect(client.app_id).to eq('a')
    end

    it 'sets #app_secret' do
      SecureRandom.stub(:hex).and_return('b')
      client = Client.new
      client.valid?
      expect(client.app_secret).to eq('b')
    end
  end

  describe 'on update' do
    it 'does not change #app_id and #app_secret' do
      client = FactoryGirl.create(:client)
      app_id = client.app_id
      app_secret = client.app_secret
      client.update_attributes(name: 'foo')

      expect(app_id).to eq(client.app_id)
      expect(app_secret).to eq(client.app_secret)
    end
  end

  describe '::authorize!' do
    it 'finds client by #app_id' do
      client = FactoryGirl.create(:client)
      expect(Client.authorize!(client.app_id).id).to eq(client.id)
    end

    it 'raises RecordNotFound if client is not found' do
      expect{ Client.authorize!('foo') }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
