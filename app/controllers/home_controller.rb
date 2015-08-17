class HomeController < ApplicationController
  def index
  	if !session[:user_id].nil?
  		redirect_to '/chat'
  	end
  end
end
