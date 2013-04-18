require 'spec_helper'

describe User do
  let(:uuid) { '2d931510-d99f-494a-8c67-87feb05e1594' }

  it 'default scope prevent deleted users from showing up' do
    user = FactoryGirl.create(:user, deleted_at: Time.current)
    expect(User.where(email: user.email).first).to be_nil
  end

  it 'is valid' do
    expect(FactoryGirl.build(:user)).to be_valid
  end

  describe 'validates' do
    it 'presence of #first_name' do
      expect(User.new).to have(1).error_on(:first_name)
    end

    it 'presence of #last_name' do
      expect(User.new).to have(1).error_on(:last_name)
    end

    it 'presence of #email' do
      expect(User.new).to have(1).error_on(:email)
    end

    it 'presence of #country_id' do
      expect(User.new).to have(1).error_on(:country_id)
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
      expect(User.new(email: user.email)).to have(1).error_on(:email)
    end

    it 'uniqueness of #access_token' do
      SecureRandom.stub(:hex).and_return('abc')
      FactoryGirl.create(:user)
      expect(User.new).to have(1).error_on(:access_token)
    end

    it 'uniqueness of #uid' do
      SecureRandom.stub(:uuid).and_return(uuid)
      FactoryGirl.create(:user)
      expect(User.new).to have(1).error_on(:uid)
    end
  end

  describe 'on create' do
    it 'sets #access_token' do
      SecureRandom.stub(:hex).and_return('a')
      user = User.new
      user.valid?
      expect(user.access_token).to eq('a')
    end

    it 'sets #uid' do
      SecureRandom.stub(:uuid).and_return(uuid)
      user = User.new
      user.valid?
      expect(user.uid).to eq(uuid)
    end
  end

  describe 'on update' do
    it 'does not change #access_token' do
      user = FactoryGirl.create(:user)
      access_token = user.access_token
      user.update_attributes(email: 'foo@bar.baz')

      expect(access_token).to eq(user.access_token)
    end

    it 'does not change #uid' do
      user = FactoryGirl.create(:user)
      uid = user.uid
      user.update_attributes(email: 'foo@bar.baz')

      expect(uid).to eq(user.uid)
    end
  end

  it '::authorize_with_token finds user by token' do
    user = FactoryGirl.create(:user)
    expect(User.authorize_with_token(user.access_token).id).to eq(user.id)
  end

  it 'makes full name out of first and last names' do
    user = User.new(first_name: 'Moses', last_name: 'Song')
    expect(user.full_name).to eq('Moses Song')
  end

  it '#soft_destroy marks user as deleted' do
    user = FactoryGirl.create(:user)
    user.soft_destroy
    expect(user.deleted_at).not_to be_nil
  end

  it '#as_json retuns limited set of attributes' do
    user = FactoryGirl.create(:user)
    expect(user.as_json.keys).to \
      include('uid', 'email', 'first_name', 'last_name', 'created_at', 'updated_at')
  end
end
