class NotesController < ApplicationController 

	before_action :signed_in_user, only: [:edit, :destroy]
	before_action :writer_of_note, only: [:edit, :destroy]

	def create
		@note = Note.new(note_params)
		if @note.save == true
			@note.save
		else
			params[:unsaved] == true
		end

		if params[:note][:view_type] == "timeline"
			redirect_to group_path(params[:note][:group_id])
		elsif params[:note][:view_type] == "list"
			redirect_to groups_list_path(params[:note][:group_id])
		end
	end

	def destroy
		group_id = Note.find(params[:id]).group_id
		Note.find(params[:id]).destroy
	    redirect_to groups_list_path(group_id)
	end

	def edit
		@note = Note.find(params[:id])
	end

	def update
		@note = Note.find(params[:note][:id])
		@note.update_attributes(note_params)
		redirect_to groups_list_path(params[:note][:group_id])
	end

	private
		def note_params
			params.require(:note).permit(:body, :pagenumber, :group_id, :user_id, :id)
		end
end
