require 'spec_helper'

describe User do

  it 'should create a new instance given a valid attribute' do
    FactoryGirl.create(:user)
  end

  it 'should require an email address' do
    user_without_email = FactoryGirl.build(:user, :missing_email)
    user_without_email.should_not be_valid
  end

  it 'should accept valid email addresses' do
    (1..3).each do |a|
      valid_user = FactoryGirl.build(:user, "valid_email_#{a}".to_sym)
      valid_user.should be_valid
    end
  end

  it 'should not accept invalid addresses' do
    (1..3).each do |a|
      invalid_user = FactoryGirl.build(:user, "invalid_email_#{a}".to_sym)
      invalid_user.should_not be_valid
    end
  end

  it 'should reject duplicate email addresses' do
    FactoryGirl.create(:user, :duplicate)
    user_with_duplicate_email = FactoryGirl.build(:user, :duplicate)
    user_with_duplicate_email.should_not be_valid
  end

  it 'should reject duplicate case insensitive email addresses' do
    FactoryGirl.create(:user, :duplicate)
    user_with_duplicate_email = FactoryGirl.build(:user, :case_insensitive_duplicate)
    user_with_duplicate_email.should_not be_valid
  end

  describe 'Password' do
  
    before(:each) do
      @user = FactoryGirl.build(:user)
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
      FactoryGirl.build(:user, :invalid_password).should_not be_valid
    end
  
    it 'should require a matching password confirmation' do
      FactoryGirl.build(:user, :invalid_password).
        should_not be_valid
    end
  
    it 'should reject short passwords' do
      FactoryGirl.build(:user, :short_password).
        should_not be_valid
    end
  end

  describe 'Password Encryption' do

    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    it 'should have an encrypted password attribute' do
      @user.should respond_to(:encrypted_password)
    end

    it 'should set the entrypted password attribute' do
      @user.encrypted_password.should_not be_blank
    end

    it 'should encrypt the password' do
      @user.encrypted_password != FactoryGirl.attributes_for(:user)[:password]
    end
  end
end
