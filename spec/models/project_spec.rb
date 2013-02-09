require 'spec_helper'
require 'date'

describe Project do

  it 'should create a new instance given a valid attribute' do
    project = FactoryGirl.build(:project)
    project.should be_valid
  end

  it 'should require a description' do
    project = FactoryGirl.build(:project, :no_description)
    project.should_not be_valid
  end

  it 'should require a user' do
    project = FactoryGirl.build(:project, :no_user)
    project.should_not be_valid
  end

  it 'should not allow creation of projects for other users'

  describe 'Deadline' do

    it 'should not require a deadline' do
      project = FactoryGirl.build(:project, :no_deadline)
      project.should be_valid
    end

    it 'should require a valid date string' do
      project = FactoryGirl.build(:project, :bad_date)
      project.deadline.should be_nil
    end
  end
end
