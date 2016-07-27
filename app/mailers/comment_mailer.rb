# -*- encoding : utf-8 -*-
class CommentMailer < ActionMailer::Base
  default from: "vivek.ranjan@assigntracker.com"

  def comment_create_mail(user,comment,assignment)
  	@user = user
  	@comment = comment
  	@assignment = assignment
  	@url = 'localhost:3000'
  	mail(:to => @user.email, :subject => "Hey Someone Commented")	
  end
  def comment_assignee_mail(user,comment,assignment)
  	@user = user
  	@comment = comment
  	@assignment = assignment
  	@url = 'localhost:3000'
  	mail(:to => @user.email, :subject => "Hey Assingment Creator commented on the assignment")	
  end
end
