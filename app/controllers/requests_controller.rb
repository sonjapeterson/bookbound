class RequestsController < ApplicationController

	def create
	end

	def confirm
		current_request = Request.find(params[:request])
		group = Group.find(current_request.group_id)
		# set request status to true
		current_request.update_attributes(status: true)
		# put requested user into the group
		group.users << User.find(current_request.requested_id)
		group.save
		flash[:notice] = "Request confirmed!"

	    notification = User.find_by(id: current_request.requester_id).notifications.build(read: false, content: User.find_by(id: current_request.requested_id).fname + " has accepted your request to read " + group.book.title, destination: "note", group: current_request.group_id)
	    notification.save

		redirect_to groups_user_path(current_user)
	end

	def destroy
		current_request = Request.find(params[:request])
		current_request.destroy
		redirect_to groups_user_path(current_user)
	end

end
