require 'spec_helper'

describe 'Project pages' do

  subject { page }

  describe 'project landing page' do
    describe 'main page' do
      let(:project) { FactoryGirl.create(:project) }

      before { sign_in project.user }

      it { should have_content(project.description) }
      it { should have_link('Start a New Project', href: '#new_project_modal') }
    end

    describe 'adding a new post' do
      let(:project) { FactoryGirl.create(:project) }

      before do
        sign_in project.user
        click_link 'Start a New Project'
      end

      it { should have_button('Post') }

#      it 'should require a description' do
#        before { fill_in 'description', with: '' }
#      end

      it 'should save with a description' do
        new_project = FactoryGirl.build(:project, user: project.user)

        fill_in 'project_description', with: new_project.description
        click_button 'Post'
        visit root_path

        should have_link(new_project.description)

        click_link new_project.description

        should have_content("User: #{new_project.user.email}")
        should have_content("Description: #{new_project.description}")
        should have_link('Delete')
      end
    end

    describe 'deleting a post', :js => true do
      let(:delete_project) { FactoryGirl.create(:project) }

      before(:each) do
        sign_in delete_project.user
        click_link delete_project.description
        click_link('Delete')
      end

      it 'should not delete a project if modal is dismissed' do
        expect { page.driver.browser.switch_to.alert.dismiss }.should_not change(Project, :count).by(-1)
        visit root_path
      
        should have_link(delete_project.description)
      end

      it 'should delete a project if modal is accepted' do
        expect { page.driver.browser.switch_to.alert.accept }.should change(Project, :count).by(-1)
        visit root_path
    
        should_not have_link(new_project.description)
      end
    end

#    describe 'editting a project' do
#      it { should have a submit button } it { should update the project list after updating }
#    end
  end
end
