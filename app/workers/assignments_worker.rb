# -*- encoding : utf-8 -*-
class AssignmentsWorker
	include Sidekiq::Worker
	
	def self.perform(id)
        UserMailer.new_assignment_created(id).deliver
	end
end				
