class LandingController < ApplicationController
  def index
    if user_signed_in?
      load_projects
    end
  end
end
