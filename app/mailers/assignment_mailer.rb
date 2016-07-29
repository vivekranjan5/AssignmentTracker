# -*- encoding : utf-8 -*-
class AssignmentMailer < ActionMailer::Base
  default from: "vivek.ranjan@assigntracker.com"

  def destroy_mail(destroyer, creator, assignment)
  	@destroyer = destroyer
  	@creator = creator
  	@assignment = assignment
  	@url = 'localhost:3000'
  	mail(to: @creator.email, subject: "Your Assignment Has been destroyed")
  end
end
