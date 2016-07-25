class CommentsController < ApplicationController
	before_filter :authenticate_user!
	def create
		@comment = @assignment.comments.new(comment_params)
		@comment.user_name = current_user.name
		@comment.save!
		respond_to do |format|
      		format.html { redirect_to @assignment}
      		format.js
    	end
 	end
	private

	def comment_params
		params.require(:comment).permit(:body)
	end
end
