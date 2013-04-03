require 'spec_helper'

describe User do
  describe '::validations' do
    it 'with no #email' do
      expect(User.new).to have(1).error_on(:email)
    end

    it 'with no #password' do
      expect(User.new).to have(1).error_on(:password)
    end

    it 'with invalid #email' do
      expect(User.new(email: 'foo')).to have(1).error_on(:email)
    end

    it 'with short #password' do
      expect(User.new(password: 'bar')).to have(1).error_on(:password)
    end

    it 'with valid attributes' do
      expect(FactoryGirl.build(:user)).to be_valid
    end
  end
end
