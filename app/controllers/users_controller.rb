class UsersController < ApplicationController
	def dashboard
	end

	def edit
	end

	def update
		current_user.update_attributes(user_params)
		redirect_to user_path
	end

	def show
	end

	private
		def user_params
			params.require(:user).permit(:email, :location, :gender, :age, :fav_books, :genre, :fav_authors, :description, :classic, :comedy, :comic, :educational, :historical, :memoir, :mystery, :nonfiction, :poetry, :pulp, :romance, :scifi, :shortstory)
		end
end
