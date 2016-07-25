class Assignment < ActiveRecord::Base
	#extend Enumerize
	include ActiveModel::ForbiddenAttributesProtection
	#many to many association with the user
	attr_accessible :title,:content,:start_date


	has_many :assignments_users, :class_name => "AssignmentsUser", :dependent => :destroy
	has_many :assigned_users , :through => :assignments_users, :source => :user
	

	#has many belongs to association with comments
	has_many :comments, :dependent => :destroy



	belongs_to :creator, :foreign_key => "creator_id", :class_name => "User"


	validates :title, presence: true
	validates :content, presence: true

	has_many :subtasks
end
