class Comment < ActiveRecord::Base
	include ActiveModel::ForbiddenAttributesProtection
	belongs_to :assingment
end
