class UsersController < ApplicationController
	def dashboard
	end

	def edit
	end

	def update
		current_user.update_attributes(user_params)
		redirect_to edit_user_path
	end

	private
		def user_params
			params.require(:user).permit(:email, :location, :gender)
		end
end
