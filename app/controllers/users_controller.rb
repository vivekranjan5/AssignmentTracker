class UsersController < ApplicationController
	def show
		@assignments = current_user.assignments
		@subtasks = current_user.subtasks
	end
	def index
	end
	def assignees
	end
end