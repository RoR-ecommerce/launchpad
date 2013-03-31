require 'spec_helper'

describe Client do
  describe 'validations with missing attributes' do
    it 'fails with no name' do
      expect(Client.new).to have(1).error_on(:name)
    end

    it 'fails with no uri' do
      expect(Client.new).to have(1).error_on(:uri)
    end

    it 'fails with no redirect_uri' do
      expect(Client.new).to have(1).error_on(:redirect_uri)
    end
  end

  describe 'validations with all attributes' do
    it 'is valid' do
      expect(FactoryGirl.build(:client)).to be_valid
    end
  end

  describe 'sets required attribute' do
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
  end
end
