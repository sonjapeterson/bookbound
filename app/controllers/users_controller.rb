class UsersController < ApplicationController

	before_action :signed_in_user, only: [:edit, :groups]
	before_action :correct_user, only: [:edit, :groups]

	def index
		@users = User.all
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		if current_user.update_attributes(user_params) && current_user.genre.update_attributes(genre_params)
			if (params[:user][:zipcode] =~ /\A(\d{5})\z/) == 0
				current_user.update_attributes(location: params[:user][:zipcode].to_region)
			end
			flash[:notice] = "Profile successfully updated"
			redirect_to user_path
		else
			flash[:notice] = "Invalid value in one or more form fields"
			redirect_to :action => "edit", :id => current_user.id
		end
	end

	def show
		@user = User.find(params[:id])
	end

	def groups
		@groups = User.find(params[:id]).groups
		@requests = Request.where(status: false)
	end

	def destroy
	    User.find(params[:id]).destroy
	    session[:user_id] = nil
	    flash[:notice] = "Account deleted."
	    redirect_to root_url
	end

	def notifications
		@user = User.find(params[:id])
	end

	private
		def user_params
			params.require(:user).permit(:email, :location, :gender, :age, :fav_books, :fav_authors, :genre, :description, :zipcode)
		end

		def genre_params
			params[:user][:genre].permit(:classic, :comedy, :comic, :educational, :historical, :memoir, :mystery, :nonfiction, :poetry, :pulp, :romance, :scifi, :shortstory)
		end
end
