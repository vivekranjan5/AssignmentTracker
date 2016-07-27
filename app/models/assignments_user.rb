# -*- encoding : utf-8 -*-
class AssignmentsUser < ActiveRecord::Base
	# many to many association with user and assignment has_many through
	include ActiveModel::ForbiddenAttributesProtection
	belongs_to :assignment
	belongs_to :user, :foreign_key => "assignee_id"
end
