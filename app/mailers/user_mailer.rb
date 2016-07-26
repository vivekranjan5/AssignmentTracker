class UserMailer < ActionMailer::Base
  default from: "vivek.ranjan@assigntracker.com"

  def welcome_email(user)
  	@user = user 	
  	@url = 'localhost:3000'
  	mail(to: @user.email, subject: "Welcome to our website")
  end

  def new_assignment_created(user)
  	@user = user
  	@url = 'localhost:3000'
  	mail(to: @user.email, subject: "Assignment Created by You")
  end

  def assignment_updated(user)
  	@user = user
  	@url = 'localhost:3000'
  	mail(to: @user.email, subject: "Assignment Updated by You")
  end
end
