require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'saves a user to the db' do
      @user = User.create(name: 'Blah Blah', email: 'test@test.com', password: '12345678', password_confirmation: '12345678')
      expect(@user).to be_present
    end

    it 'confirms the password w/ correct password' do
      @user = User.create(name: 'Blah Blah', email: 'test@test.com', password: '12345678', password_confirmation: '12345678')
      expect(@user.password).to eq(@user.password_confirmation)
    end

    it 'confirms the password w/ incorrect password_confirmation' do
      @user = User.create(name: 'Blah Blah', email: 'test@test.com', password: '12345678', password_confirmation: '1234')
      expect(@user.password).not_to eq(@user.password_confirmation)
    end

    it 'does not save without name' do
      @user = User.create(name: nil, email: 'test@test.com', password: '12345678', password_confirmation: '12345678')
      expect(@user.errors.full_messages).to include "Name can't be blank"
    end

    it 'does not save without email' do
      @user = User.create(name: 'Blah Blah', email: nil, password: '12345678', password_confirmation: '12345678')
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end

    it 'does not save without password' do
      @user = User.create(name: 'Blah Blah', email: 'test@test.com', password: nil, password_confirmation: nil)
      expect(@user.errors.full_messages).to include "Password can't be blank"
    end

    it 'validates password minimum length' do
      @user = User.create(name: 'Blah Blah', email: 'test@test.com', password: '1234', password_confirmation: '1234')
      expect(@user.errors.full_messages).to include "Password is too short (minimum is 8 characters)"
    end

    it 'creates an account while ignoring casing' do
      @user = User.create(name: 'Blah Blah', email: 'test@test.COM', password: '12345678', password_confirmation: '12345678')
      expect(@user.email).to eq('test@test.com')
    end

    it 'creates an account while ignoring whitespaces' do
      @user = User.create(name: 'Blah Blah', email: '   test@test.COM   ', password: '12345678', password_confirmation: '12345678')
      expect(@user.email).to eq('test@test.com')
    end
  end

  describe '.authenticate_with_credentials' do
    it 'successfully logs in with correct credentials' do
      @user = User.create(name: 'Blah Blah', email: 'test@test.com', password: '12345678', password_confirmation: '12345678')
      expect(User.authenticate_with_credentials('test@test.com', '12345678')).to eq(@user)
    end

    it 'successfully logs in if email has different casing' do
      @user = User.create(name: 'Blah Blah', email: 'test@test.COM', password: '12345678', password_confirmation: '12345678')
      expect(User.authenticate_with_credentials('test@test.com', '12345678')).to eq(@user)
    end

    it 'successfully logs in if email has whitespaces' do
      @user = User.create(name: 'Blah Blah', email: 'test@test.com', password: '12345678', password_confirmation: '12345678')
      expect(User.authenticate_with_credentials('    test@test.com   ', '12345678')).to eq(@user)
    end
  end
end
