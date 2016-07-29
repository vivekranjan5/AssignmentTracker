# -*- encoding : utf-8 -*-
require 'elasticsearch/model'
class Comment < ActiveRecord::Base
	include ActiveModel::ForbiddenAttributesProtection
	belongs_to :assignment
	belongs_to :user
end
