require 'spec_helper'

describe 'User pages' do

  subject { page }

  describe 'index' do
    before(:each) { visit root_path }

    after(:all) { User.delete_all }

    it { should have_link('Login', href: new_user_session_path ) }
    it { should have_link('Sign Up', href: new_user_registration_path ) }
  end

  describe 'sign up' do
    before(:each) { visit root_path }

    it 'should take you to the sign up page if you click the sign up button' do
      click_link 'Sign Up'

      should have_content('Sign up')
      should have_field('user_email')
      should have_field('user_password')
      should have_field('user_password_confirmation')
    end
  end

  describe 'sign in' do
    let(:user) { FactoryGirl.create(:user) }

    before do 
      sign_in user
    end

    describe 'my projects' do
      it { should have_selector('h3', text: 'My Projects') }
    end

    describe 'edit profile' do
      it { should have_link('Edit Profile', href: edit_user_registration_path) }

      describe 'page' do
        before { click_link 'Edit Profile' }

        it { should have_content('Edit User') }
        it { should have_content(user.email) }

        describe 'password change' do
          let(:new_password) { user.password + user.password }

          before do
            fill_in 'user_password', with: new_password
            fill_in 'user_password_confirmation', with: new_password
            fill_in 'user_current_password', with: user.password
          end

          it 'should change the password' do
            original_password = user.encrypted_password
            click_button 'Update'
            user.reload.encrypted_password.should_not == original_password
          end
        end
      end
    end

    describe 'logging out' do
      it { should have_link('Logout', href: destroy_user_session_path) }

      describe 'click loggout button' do
        before { click_link 'Logout' }
        it { should have_link('Login', href: new_user_session_path) }
      end

      describe 'logging back in' do
        it { should have_content(user.email) }
      end

      describe 'logged in as' do
        it { should have_content("Logged in as #{user.email}") }
      end

      describe 'start a new project' do
        it { should have_link('Start a New Project', href: '#new_project_modal') }
      end
    end
  end
end
