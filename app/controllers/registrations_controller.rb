class RegistrationsController < Devise::RegistrationsController
  def cancel
    super
  end

  def create
    super
  end

  def new
    super
  end

  def edit
    # TODO: this might need to be used in more places, as the projects sidebar is loaded every time a user is logged in
    @project = Project.new
    @project_items = current_user.projects
    super
  end

  def update
    super
  end

  def destroy
    super
  end
end
