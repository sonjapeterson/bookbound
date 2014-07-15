class UsersController < ApplicationController
	def dashboard
	end

	def edit
	end

	def update
		current_user.update_attributes(user_params)
		current_user.genre.update_attributes(genre_params)
		redirect_to user_path
	end

	def show
	end

	private
		def user_params
			genreforuser = Genre.new
			genreforuser.update_attributes(user_id: current_user.id)
			params.require(:user).permit(:email, :location, :gender, :age, :fav_books, :fav_author, :genre)
		end

		def genre_params
		
			params.permit(:comic, :comedy)
		end
end
