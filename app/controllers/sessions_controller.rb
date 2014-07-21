class SessionsController < ApplicationController 
	def create
    	user = User.from_omniauth(env["omniauth.auth"])
    	session[:user_id] = user.id
  		redirect_back_or(groups_user_path(user.id))
  	end

  	def destroy
  		session[:user_id] = nil
  		redirect_to root_url
  	end
end
