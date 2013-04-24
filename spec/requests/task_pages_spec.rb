require 'spec_helper'

describe "Task Pages" do

  subject { page }

  describe 'project page' do
    let(:task) { FactoryGirl.create(:task) }

    before do
      puts "user #{task.project.user.id}"
      sign_in task.project.user
      visit project_path(task.project.id)
    end

    it 'should have an add task button' do
      should have_link('Add a new task')
    end

    it 'should list attached tasks from the project index page' do
      should have_content "#{task.description}"
    end

    it 'should have a delete task button for each task' do
      should have_link "Delete Task", href: "#delete_task_modal"
    end

    it 'should have an edit task button for each task' do
      should have_link "Edit Task", href: "#edit_task"
    end

    it 'should have a complete task button for each task' do
      should have_button "Complete Task", href: "#complete_task"
    end

    it 'should have a task information button for each task' do
      should have_button "Task Information", href: "#task_information"
    end

    it 'should check for n+1 problems...'
  end

  describe 'add task page' do

  end

  describe 'edit task page' do

  end

  describe 'task information page' do

  end
end
