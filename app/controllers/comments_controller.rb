# -*- encoding : utf-8 -*-
class CommentsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :set_assignments

	
	def create
		@comment = @assignment.comments.new(comment_params)
		@comment.user_name = current_user.name
		@commentor_id = current_user.id
		@comment.save!
		if @comment.assignment.assignments_users.where("assignee_id = ? ",@commentor_id).empty?
			@user = User.find(@comment.assignment.assignments_users.where("assignor_id = ?", @commentor_id).first.assignee_id)
		else
			@user = User.find(@comment.assignment.assignments_users.where("assignee_id = ?", @commentor_id).first.assignor_id)
		end
		CommentsWorker.delay.perform(@user,@comment,@assignment)
		respond_to do |format|
      		format.html { redirect_to @assignment}
      		format.js
    	end
 	end
	private

	def set_assignments
		@assignment = Assignment.find(params[:assignment_id])
	end

	def comment_params
		params.require(:comment).permit(:body)
	end
end
