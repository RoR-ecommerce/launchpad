require 'spec_helper'

describe App do
  it 'is valid' do
    expect(FactoryGirl.build(:app)).to be_valid
  end

  describe 'validates' do
    it 'presence of #name' do
      expect(App.new).to have(1).error_on(:name)
    end

    it 'presence of #uri' do
      expect(App.new).to have(1).error_on(:uri)
    end

    it 'presence of #redirect_uri' do
      expect(App.new).to have(1).error_on(:redirect_uri)
    end

    describe 'uniqueness' do
      before(:each) do
        SecureRandom.stub(:hex).and_return('abc')
        FactoryGirl.create(:app)
      end

      it 'of #client_id' do
        expect(App.new).to have(1).error_on(:client_id)
      end

      it 'of #client_secret' do
        expect(App.new).to have(1).error_on(:client_secret)
      end

      it 'of #uri' do
        expect(App.new).to have(1).error_on(:uri)
      end

      it 'of #redirect_uri' do
        expect(App.new).to have(1).error_on(:redirect_uri)
      end
    end
  end

  describe 'on create' do
    it 'sets #client_id' do
      SecureRandom.stub(:hex).and_return('a')
      app = App.new
      app.valid?
      expect(app.client_id).to eq('a')
    end

    it 'sets #client_secret' do
      SecureRandom.stub(:hex).and_return('b')
      app = App.new
      app.valid?
      expect(app.client_secret).to eq('b')
    end
  end

  describe 'on update' do
    it 'does not change #client_id and #client_secret' do
      app = FactoryGirl.create(:app)
      client_id = app.client_id
      client_secret = app.client_secret
      app.update_attributes(name: 'foo')

      expect(client_id).to eq(app.client_id)
      expect(client_secret).to eq(app.client_secret)
    end
  end

  describe '::authorize!' do
    it 'finds app by #client_id' do
      app = FactoryGirl.create(:app)
      expect(App.authorize!(app.client_id).id).to eq(app.id)
    end

    it 'raises RecordNotFound if app is not found' do
      expect{ App.authorize!('foo') }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
