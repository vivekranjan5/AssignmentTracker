class Submit < ActiveRecord::Base
	# many to many association with user and assignment has_many through
	belongs_to :assignment
	belongs_to :user
end
