class UsersController < ApplicationController
  def signup
  	@user = User.new
  end

  def create
  	@user = User.create(user_params)

  	if @user.save
  		
  		session[:user_id] = @user.id

  		flash.notice = "Welcome, #{@user.username}! Thanks for signing up."

  		redirect_to '/'
  	else
  		flash.alert = 'Error. User was not created. Please try again.'

  		redirect_to '/users/signup'
  	end
  end

  private
  	def user_params
    	params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end
