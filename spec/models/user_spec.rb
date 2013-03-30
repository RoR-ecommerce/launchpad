require 'spec_helper'

describe User do
  describe 'validations with missing attributes' do
    it 'fails with no email' do
      expect(User.new).to have(1).error_on(:email)
    end

    it 'fails with no password' do
      expect(User.new).to have(1).error_on(:password)
    end

    it 'fails with invalid email' do
      expect(User.new(email: 'foo')).to have(1).error_on(:email)
    end

    it 'fails with short password' do
      expect(User.new(password: 'bar')).to have(1).error_on(:password)
    end
  end

  describe 'validations with all attributes' do
    it 'is valid' do
      expect(FactoryGirl.build(:user)).to be_valid
    end
  end
end
