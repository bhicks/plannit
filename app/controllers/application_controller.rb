class ApplicationController < ActionController::Base
  protect_from_forgery

  def signed_in_user
    if current_user.nil?
      flash[:error] = "Please sign in to access your project information."
      logger.debug 'current_user.nil, redirecting'
      redirect_to root_path
    else
      load_projects
    end
  end

  def load_projects
    @project = Project.new
    @project_items = current_user.projects
  end
end
