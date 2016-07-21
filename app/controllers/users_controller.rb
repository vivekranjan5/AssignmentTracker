class UsersController < ApplicationController
	def show
		@assignments = current_user.assignments
	end
end