class AssignmentsUser < ActiveRecord::Base
	# many to many association with user and assignment has_many through
	include ActiveModel::ForbiddenAttributesProtection
	belongs_to :assignment
	belongs_to :user
end
