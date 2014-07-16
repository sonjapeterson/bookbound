class NotesController < ApplicationController
	def create
		@note = Note.new(note_params)
		@note.save
		
		redirect_to group_path(params[:note][:group_id])
	end

	def destroy
	end

	private
		def note_params
			params.require(:note).permit(:body, :pagenumber, :group_id, :user_id)
		end
end
