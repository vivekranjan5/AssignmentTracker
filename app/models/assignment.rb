class Assignment < ActiveRecord::Base
	#many to many association with the user
	attr_accessible :title,:content,:start_date
	has_many :users , :through => :submits
	has_many :submits
	belongs_to :creator, :foreign_key => "creator_id", :class_name => "User"

	validates :title, presence: true
	validates :content, presence: true
	
	
end
