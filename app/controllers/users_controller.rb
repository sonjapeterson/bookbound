class UsersController < ApplicationController
	before_action :signed_in_user, only: [:edit, :groups]
	before_action :correct_user, only: [:edit, :groups]

	def dashboard
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		current_user.update_attributes(user_params)
		current_user.genre.update_attributes(genre_params)
		redirect_to user_path
	end

	def show
		@user = User.find(params[:id])
	end

	def groups
		@groups = User.find(params[:id]).groups
		@requests = Request.where(status: false)
	end

	private
		def user_params
			params.require(:user).permit(:email, :location, :gender, :age, :fav_books, :fav_authors, :genre, :description)
		end

		def genre_params
			params[:user][:genre].permit(:classic, :comedy, :comic, :educational, :historical, :memoir, :mystery, :nonfiction, :poetry, :pulp, :romance, :scifi, :shortstory)
		end
end
