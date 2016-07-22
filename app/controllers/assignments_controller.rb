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
    @temp_assignment = @assignment.assignments_users.where(:user_id => current_user.id)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @assignment }
    end
  end

  # GET /assignments/new
  # GET /assignments/new.json
  def new
    @assignment = Assignment.new

    @all_users = User.all

    @assignment_user = @assignment.assignments_users.build
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @assignment }
    end
  end

  # GET /assignments/1/edit
  def edit
    @assignment = return_if_assignment_exists?

    @all_users = User.all

    @assignment_user = @assignment.assignments_users.build
  end

  # POST /assignments
  # POST /assignments.json
  def create
    params[:assignment][:start_date] = DateTime.current
    @assignment = current_user.created_assignments.create(params[:assignment])
    params[:users][:id].each do |user|
      if !user.empty?
        @assignment.assignments_users.build(:user_id => user, :current_status => "Assigned(Initial)", :alloted_date => DateTime.current)
        
      end
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
    respond_to do |format|
      @assignment = return_if_assignment_exists?
      if @assignment.update_attributes(params[:assignment])
        params[:users][:id].each do |user_id|
          if !user_id.empty?
            @assignment.assignments_users.build(:user_id => user_id)
          end
        end
        @assignment.assignments_users.build(:current_status => "In Progress")
        
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
