class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  #association with assignments in the form of creator
  has_many :tasks, :class_name => "Assignment", :foreign_key => "creator_id"
  #many to many association with assignment through submits
  has_many :assignments, :through => :submits
  has_many :submits

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name


end
