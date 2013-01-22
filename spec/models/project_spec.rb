require 'spec_helper'
require 'date'

describe Project do

  def generate_user
    @user = User.create!(@user_attr)
  end

  before(:each) do
    @attr = {
      :description => 'one awesoem project',
      :deadline => DateTime.new,
    }

    @user_attr = {
      :email => 'user@example.com',
      :password => 'pleasehammerdonthurtem',
      :password_confirmation => 'pleasehammerdonthurtem',
    }

    generate_user
  end

  it 'should create a new instance given a valid attribute' do
    project = @user.projects.build(@attr)
    project.should be_valid
  end

  it 'should require a description' do
    project = Project.create(@attr.merge(:description => ''))
    project.should_not be_valid
  end

  it 'should require a user' do
    project = Project.create(@attr)
    project.should_not be_valid
  end

  describe 'Deadline' do

    it 'should not require a deadline' do
      project = Project.create(@attr.merge(:deadline => ''))
      project.should_not be_valid
    end

    it 'should require a valid date string' do
      project = Project.create(@attr.merge(:deadline => 'notadate'))
      project.should_not be_valid
    end
  end
end
