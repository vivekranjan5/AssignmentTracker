class UsersController < ApplicationController
	def show
		@assignments = current_user.assignments
	end
	def index
	end
	def assignees
	end
end