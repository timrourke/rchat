class SessionsController < ApplicationController
  def login
  	@user = User.find_by_email(params[:email])

  	if @user && @user.authenticate(params[:password])
  		session[:user_id] = @user.id

  		flash.notice = "#{@user.username} successfully logged in."

  		redirect_to '/chat'
  	else
  		flash.alert = "Username or password is incorrect."

  		redirect_to '/'
  	end
  end

  def logout
  	session[:user_id] = nil

  	redirect_to '/'
  end
end
