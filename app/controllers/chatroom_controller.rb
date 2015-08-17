class ChatroomController < ApplicationController
   def index
    if session[:user_id].nil?
      flash.alert = "You must be authorized to chat. Please log in or sign up."

      redirect_to '/'
    else
    	@user = User.find(session[:user_id])
    end
  end
end
