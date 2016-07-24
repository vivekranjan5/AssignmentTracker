class Assignment < ActiveRecord::Base
	#extend Enumerize
	#many to many association with the user
	attr_accessible :title,:content,:start_date


	has_many :assignments_users, :class_name => "AssignmentsUser", :dependent => :destroy
	has_many :assigned_users , :through => :assignments_users, :source => :user
	




	belongs_to :creator, :foreign_key => "creator_id", :class_name => "User"

	validates :title, presence: true
	validates :content, presence: true

	#enumerize the status of project

	#enumerize :current_status, 	in: [:assigned, :inprogress, :completed]
	

	
	
	
end
