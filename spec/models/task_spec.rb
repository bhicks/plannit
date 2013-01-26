require 'spec_helper'
require 'date'

describe Task do
  it 'should create a new instance given a valid attribute' do
    project = FactoryGirl.build(:task)
    project.should be_valid
  end

  it 'should require a description' do
    project = FactoryGirl.build(:task, :no_description)
    project.should_not be_valid
  end

  it 'should require a project' do
    project = FactoryGirl.build(:task, :no_project)
    project.should_not be_valid
  end

  describe 'Deadline' do
    it 'should not require a deadline' do
      project = FactoryGirl.build(:task, :no_deadline)
      project.should be_valid
    end

    it 'should require a valid date string' do
      project = FactoryGirl.build(:task, :bad_date)
      project.deadline.should be_nil
    end
  end

  describe 'Completed Date/Time' do
    it 'should not require a completed date/time' do
      project = FactoryGirl.build(:task, :no_completed_date)
      project.should be_valid
    end

    it 'should require a valid completed date string' do
      project = FactoryGirl.build(:task, :bad_completed_date)
      project.completed_datetime.should be_nil
    end

    it 'should default not completed' do
      project = FactoryGirl.build(:task, :no_default_completed)
      project.completed.should be_false
    end
  end
end
