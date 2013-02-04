require 'spec_helper'

describe 'Project pages' do

  subject { page }

  describe 'project landing page' do
    let(:project) { FactoryGirl.create(:project) }

    describe 'main page' do
      before { sign_in project.user }

      it { should have_content(project.description) }
      it { should have_link('Start a New Project', href: '#new_project_modal') }
    end

    describe 'should not be accessible unless logged in' do
      before do
        visit project_path(project.id)
      end

      it "should not be accessible if you're not signed in" do
        should_not have_content("User: #{project.user.email}")
        should_not have_content("Description: #{project.description}")
      end
    end

    describe 'should not be accessible by another logged in user' do
      let(:other_project) { FactoryGirl.create(:project) }

      before do
        sign_in project.user
        visit project_path(other_project.id)
      end

      it { should_not have_content("User: #{other_project.user.email}") }
      it { should_not have_content("Description: #{other_project.user.email}") }
    end
  end
end
