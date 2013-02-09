class ProjectsController < ApplicationController
  before_filter :correct_user,  only: [:show, :delete, :edit, :update]
  respond_to :html, :js

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @show_project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @show_project }
    end
  end

  # GET /projects/1/edit
  def edit
    @edit_project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.json
  def create
    @create_project = current_user.projects.build(params[:project])
    flash[:notice] = "Project #{@create_project.description} successfully created" if @create_project.save
    respond_with(@create_project, layout: !request.xhr?)
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @edit_project = Project.find(params[:id])

    respond_to do |format|
      if @edit_project.update_attributes(params[:project])
        format.html { redirect_to @edit_project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @edit_project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    project = Project.find(params[:id])
    project.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end

  private
    def correct_user
      project = current_user ? current_user.projects.find_by_id(params[:id]) : nil
      if project.nil?
        flash[:error] = "Only project owners can view project information."
        logger.debug 'project.nil, redirecting'
        redirect_to root_path 
      else
        load_projects
      end
    end
end
