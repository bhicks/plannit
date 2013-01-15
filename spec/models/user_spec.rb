require 'spec_helper'

describe User do

  before(:each) do
    @attr = {
      :email => 'user@example.com',
      :password => 'pleasehammerdonthurtem',
      :password_confirmation => 'pleasehammerdonthurtem',
    }
  end

  it 'should create a new instance given a valid attriute' do
    User.create!(@attr)
  end

  it 'should require an email address' do
    user_without_email = User.create(@attr.merge(:email => ''))
    user_without_email.should_not be_valid
  end

  it 'should accept valid email addresses' do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |a|
      valid_user = User.create(@attr.merge(:email => a))
      valid_user.should be_valid
    end
  end

  it 'should not accept invalid addresses' do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |a|
      invalid_user = User.create(@attr.merge(:email => a))
      invalid_user.should_not be_valid
    end
  end

  it 'should reject duplicate email addresses' do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  it 'should reject duplicate case insensitive email addresses' do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr.merge(:email => 'USER@EXAMPLE.COM'))
    user_with_duplicate_email.should_not be_valid
  end

  describe 'Password' do
  
    before(:each) do
      @user = User.new(@attr)
    end
  
    it 'should have a password attribute' do
      @user.should respond_to(:password)
    end
  
    it 'should have a password confirmation attribute' do
      @user.should respond_to(:password)
    end
  end

  describe 'Password Validation' do
  
    it 'should require a password' do
      User.new(@attr.merge(:password => '', :password_confirmation => '')).should_not be_valid
    end
  
    it 'should require a matching password confirmation' do
      User.new(@attr.merge(:password_confirmation => 'invalid')).
        should_not be_valid
    end
  
    it 'should reject short passwords' do
      User.new(@attr.merge(:password => 'short', :password_confirmation => 'short')).
        should_not be_valid
    end
  end

  describe 'Password Encryption' do

    before(:each) do
      @user = User.create!(@attr)
    end

    it 'should have an encrypted password attribute' do
      @user.should respond_to(:encrypted_password)
    end

    it 'should set the entrypted password attribute' do
      @user.encrypted_password.should_not be_blank
    end

    it 'should encrypt the password' do
      @user.encrypted_password != @attr[:password]
    end
  end
end
