class Comment < ActiveRecord::Base
	include ActiveModel::ForbiddenAttributesProtection
	belongs_to :assignment
	belongs_to :user

	
end
