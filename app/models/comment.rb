# -*- encoding : utf-8 -*-
require 'elasticsearch/model'
class Comment < ActiveRecord::Base
	include ActiveModel::ForbiddenAttributesProtection

	# Elastic implementatino for comment

	



	belongs_to :assignment
	belongs_to :user
end
