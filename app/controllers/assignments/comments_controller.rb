class Assignments::CommentsController < CommentsController
	before_filter :set_assignments

	private

	def set_assignments
		@assignment = Assignment.find(params[:assignment_id])
	end
end