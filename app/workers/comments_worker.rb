# -*- encoding : utf-8 -*-
class CommentsWorker
	include Sidekiq::Worker
	
	def self.perform(user,comment,assignment)
		CommentMailer.comment_create_mail(user, comment, assignment).deliver
	end
end				
