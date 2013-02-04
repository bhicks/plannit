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

    describe 'adding a new post' do
      let(:new_project) { FactoryGirl.build(:project, user: project.user) }
    
      before do
        sign_in project.user
        click_link 'Start a New Project'
      end
    
      it { should have_button('Post') }
    
      it 'should require a description' do
# TODO: add this
#       before { fill_in 'description', with: '' }
      end
    
      it 'should save with a description' do
        fill_in 'project_description', with: new_project.description
        expect { click_button 'Post' }.to change(Project, :count).by(1)
        visit root_path
    
        should have_link(new_project.description)
    
        click_link new_project.description
    
        should have_content("User: #{new_project.user.email}")
        should have_content("Description: #{new_project.description}")
        should have_link('Delete')
      end
    end

    describe 'editing a project' do
      before do
        sign_in project.user
        click_link project.description
      end

      it { should have_link('Edit') }

      describe 'edit page' do
        before { click_link('Edit') }

        it { should have_field('Description') }
        it { should have_button('Save') }

        it 'should update the project when saving' do
          original_description = project.description
          new_description = project.description + ' but newer'
          fill_in('Description', new_description)
          expect { click_button('Save') }.to_not change(Project, :count)

          project.reload.description.should_not == original_description

          should have_link(project.description)
        end
      end
    end
  end
end
