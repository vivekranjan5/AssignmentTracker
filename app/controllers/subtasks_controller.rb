class SubtasksController < ApplicationController


  def new
  	@assignment = Assignment.find(params[:assignment_id])
  	@subtask = Subtask.new
  end

  def create
  	@assignment = Assignment.find(params[:assignment_id])
  	@subtask = @assignment.subtasks.create(params[:subtask])
  	if @subtask.save!
  		redirect_to @assignment
  	else
  		render 'new', :notice => "Some errors were there"
  	end
  end

  def show
  	if Subtask.where(:id => params[:id]).exists?
  		@subtask = Subtask.find(params[:id])
  		@assignment = Assignment.find(params[:assignment_id])
  	else
  		redirect_to @assignment, :notice => "Some Error Occured"
  	end
  end

  def destroy
  	@assignment = Assignment.find(params[:assignment_id])
  	if Subtask.where(:id => params[:id]).exists?
  		@subtask = Subtask.find(params[:id])
  		@assignment.subtasks.where(:id => @subtask.id).first.destroy
  		redirect_to @assignment
  	else
  		redirect_to @assignment, :notice => "Assignment was already destroyed"
  	end
  end
end
