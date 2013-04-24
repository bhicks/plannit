class TasksController < ApplicationController
  before_filter :correct_user, only: []
  respond_to :html, :js

  def show

  end

  def create
    @create_task = current
  end

  def destroy

  end

  def edit

  end

  def update

  end

  private
    def correct_user
      task = current_user ? current_user.projects.tasks.find_by_id(params[:id]) : nil
      if task.nil?
        flash[:error] = "Only task owners can view task information."
        logger.debug 'task.nil, redirecting'
        redirect_to root_path
      else

      end
    end
end
