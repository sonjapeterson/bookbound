class RequestsController < ApplicationController

	def create
	end

	def confirm
		# set request status to true
		# put requested user into the group
		@group.users << User.find(params[:requested_user_id])
	end

	def destroy
		# delete request
	end

end
