class CommentsController < ApplicationController
	before_filter :authenticate_user!
	before_filter :set_assignments

	
	def create
		@comment = @assignment.comments.new(comment_params)
		@comment.user_name = current_user.name
		@creator_user = @assignment.creator
		@comment.save!
		if current_user!=@creator_user
			CommentMailer.comment_create_mail(@user, @comment, @assignment).deliver
		else
			@assignment.assigned_users.each do |user|
				CommentMailer.comment_assignee_mail(user, @comment, @assignment).deliver	
			end
		end
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
