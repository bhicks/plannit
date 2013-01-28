require 'spec_helper'

describe 'User pages' do

  subject { page }

  describe 'index' do
    let(:user) { FactoryGirl.create(:user) }

    before(:each) do
      visit root_path
    end

    after(:all) { User.delete_all }

    it { should have_link('Login', href: new_user_session_path ) }
    it { should have_link('Sign Up', href: new_user_registration_path ) }
  end

end
