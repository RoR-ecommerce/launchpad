require 'spec_helper'

describe User do
  it 'is valid' do
    expect(FactoryGirl.build(:user)).to be_valid
  end

  describe 'validates' do
    it 'presence #email' do
      expect(User.new).to have(1).error_on(:email)
    end

    it 'presence of #password' do
      expect(User.new).to have(1).error_on(:password)
    end

    it 'format of #email' do
      expect(User.new(email: 'foo')).to have(1).error_on(:email)
    end

    it 'length of #password' do
      expect(User.new(password: 'bar')).to have(1).error_on(:password)
    end

    it 'uniqueness of #email' do
      user = FactoryGirl.create(:user)
      new_user = User.new(email: user.email)
      new_user.valid?
      expect(new_user).to have(1).error_on(:email)
    end

    it 'uniqueness of #access_token' do
      SecureRandom.stub(:hex).and_return('abc')
      FactoryGirl.create(:user)
      user = User.new
      user.valid?
      expect(user).to have(1).error_on(:access_token)
    end
  end

  describe 'on create' do
    it 'sets #access_token' do
      SecureRandom.stub(:hex).and_return('a')
      user = User.new
      user.valid?
      expect(user.access_token).to eq('a')
    end
  end

  describe 'on update' do
    it 'does not change #access_token' do
      user = FactoryGirl.create(:user)
      access_token = user.access_token
      user.update_attributes(email: 'foo@bar.baz')

      expect(access_token).to eq(user.access_token)
    end
  end

  describe 'class methods' do
    it '::authorize_with_token' do
      user = FactoryGirl.create(:user)
      expect(User.authorize_with_token(user.access_token).id).to eq(user.id)
    end
  end
end
