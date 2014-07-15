class UsersController < ApplicationController
	def dashboard
	end

	def edit
	end

	def update
		current_user.update_attributes(user_params)
		current_user.genre.create()
		redirect_to user_path
	end

	def show
	end

	private
		def user_params
			params.require(:user).permit(:email, :location, :gender, :age, :fav_books, :fav_author)
		end
end
