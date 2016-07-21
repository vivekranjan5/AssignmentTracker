class Assignment < ActiveRecord::Base
	#many to many association with the user
	has_many :users , :through => :submits
	has_many :submits
	belongs_to :creator, :foreign_key => "creator_id", :class_name => "User"
end
