class UserMailer < ActionMailer::Base

	default :from => "harrycollins86@gmail.com"

	def registration_confirmation(user)
		@user = user
		@url = confirm_email_user_url(user.confirm_token)
		mail(:to => "#{user.username} <#{user.email}>", :subject => "Registration Confirmation")
	end

 end