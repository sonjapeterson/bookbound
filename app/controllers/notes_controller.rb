class NotesController < ApplicationController
	def create
		@note = Note.new(note_params)
		binding.pry
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
	end

	private
		def note_params
			params.require(:note).permit(:body, :pagenumber, :group_id, :user_id)
		end
end
