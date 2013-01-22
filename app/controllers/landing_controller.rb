class LandingController < ApplicationController
  def index
    if user_signed_in?
      @project = Project.new
      @project_items = current_user.projects
    end
  end
end
