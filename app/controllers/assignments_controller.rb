# -*- encoding : utf-8 -*-
class AssignmentsController < ApplicationController
  # GET /assignments
  # GET /assignments.json

  before_filter :return_if_assignment_exists?, :only => [:show, :edit, :destroy, :assignees]
  before_filter :authenticate_user!
  before_filter :beautify_search_url, :only => [:index]
  def index
    #@assignments = Assignment.order("created_at DESC")
    if params[:query].present?
      @assignments = Assignment.custom_search(params[:query]).records
  
    else
      @assignments = Assignment.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @assignments }
    end
  end

  # GET /assignments/1
  # GET /assignments/1.json
  def show
    #@@assignment = return_if_assignment_exists?
    @temp_assignment = @assignment.assignments_users.where(:assignee_id => current_user.id)
    @comments = @assignment.comments
    @subtasks = @assignment.subtasks
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
  end

  # POST /assignments
  # POST /assignments.json
  def create
    @assignment = current_user.created_assignments.create(assignment_params)
    @assignment.subtasks.create(params[:assignment][:subtask])
    respond_to do |format|
      if @assignment.save
        AssignmentsWorker.delay.perform(current_user.id)
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
      if @assignment.update_attributes(assignment_params)
        UserMailer.assignment_updated(current_user).deliver
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
    @creator = @assignment.creator
    AssignmentMailer.destroy_mail(current_user, @creator, @assignment).deliver
    @assignment.destroy
    respond_to do |format|
      format.html { redirect_to assignments_url, :notice => "Assignment has been destroyed" }
      format.json { head :no_content }
    end
  end


  def assignees
    #@assignment = return_if_assignment_exists?
    @alloted_users = @assignment.assigned_users
    if @alloted_users.count == 0
      @all_users = User.all
    else
      @all_users = []
      User.all.each do |user|
        unless @alloted_users.include? user
          @all_users << user
        end
      end
    end
    @assignment_user = @assignment.assignments_users.build
  end
  
  def createassignees
    @assignment = Assignment.find_by_id(params[:id])
    params[:users][:id].each do |user|
     if !user.empty?
       @assignment.assignments_users.create(:assignee_id => user, :assignor_id => current_user.id)    
      end
    end
    
      redirect_to assignment_path(@assignment)
    
  end

  def incstatus
    @assignment = Assignment.find_by_id(params[:id])
    @assignment.assignments_users.where(:assignee_id => current_user.id).first.increment!("current_status")
    @assignment.save!
    redirect_to @assignment
  end

  private

  def return_if_assignment_exists?
    @valid_assignments = Assignment.where(:id => params[:id])
    if @valid_assignments.empty?
      redirect_to root_path
    else
      @assignment = @valid_assignments.first
    end
  end

  def assignment_params
    params.require(:assignment).permit(:title,:content)
  end

  def beautify_search_url
    redirect_to search_assignments_path(query: params[:q]) if params[:q].present?
  end

end
