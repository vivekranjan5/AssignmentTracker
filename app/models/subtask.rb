# -*- encoding : utf-8 -*-
class Subtask < ActiveRecord::Base
	belongs_to :assignment
end
