class AssignmentsController < ApplicationController
  # GET /assignments
  # GET /assignments.json

  before_filter :return_if_assignment_exists?, :only => [:show, :edit, :destroy]
  
  def index
    @assignments = Assignment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @assignments }
    end
  end

  # GET /assignments/1
  # GET /assignments/1.json
  def show
    @assignment = return_if_assignment_exists?

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @assignment }
    end
  end

  # GET /assignments/new
  # GET /assignments/new.json
  def new
    @assignment = Assignment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @assignment }
    end
  end

  # GET /assignments/1/edit
  def edit
    @assignment = return_if_assignment_exists?
  end

  # POST /assignments
  # POST /assignments.json
  def create
    @assignment = current_user.tasks.create(params[:assignment])
    @users_email_list = params[:assignee].split(',')
    @users_email_list.each do |email|
      @user = User.find_by_email(email)
      @assignment.users << @user
    end
    respond_to do |format|
      if @assignment.save
        format.html { redirect_to @assignment, notice: 'Assignment was successfully created.' }
        format.json { render json: @assignment, status: :created, location: @assignment }
      else
        format.html { render action: "new" }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /assignments/1
  # PUT /assignments/1.json
  def update
    @users_email_list = params[:assignee].split(',')
    respond_to do |format|
      if @assignment.update_attributes(params[:assignment])
        @assignment.users.clear
        @users_email_list.each do |email|
          @user = User.find_by_email(email)
          @assignment.users << @user
        end
        format.html { redirect_to @assignment, notice: 'Assignment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1
  # DELETE /assignments/1.json
  def destroy
    @assignment = return_if_assignment_exists?
    @assignment.destroy

    respond_to do |format|
      format.html { redirect_to assignments_url }
      format.json { head :no_content }
    end
  end

  private

  def return_if_assignment_exists?
    @valid_assignments = Assignment.where(:id => params[:id])
    if @valid_assignments.empty?
      redirect_to root_path
    else
      @valid_assignments.first
    end
  end


end
