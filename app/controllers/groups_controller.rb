class GroupsController < ApplicationController

  autocomplete :user, :name, :extra_data => [:image], :display_value => :show_name_and_image, :select_value => :set_name_as_value
  autocomplete :book, :title

  before_action :signed_in_user, only: [:show]
  before_action :member_of_group, only: [:show]

  def new
   @group = Group.new
   @isbn = params[:isbn]
  end

  def create
    @group = Group.new(status: true)
    @group.save
    @group.users << current_user
    @bookz = GoogleBooks.search(params[:isbn], {:api_key => 'AIzaSyAs8X56EGpdbQnW5WswlTNcItzLZGP7uLI'})

    chosenbook = @bookz.first
    @book = Book.new(title: chosenbook.title, author: chosenbook.authors, publisher: chosenbook.publisher, datepublished: chosenbook.published_date, pagecount: chosenbook.page_count, summary: chosenbook.description, imagelinklarge: chosenbook.image_link, imagelinksmall: chosenbook.image_link, previewlink: chosenbook.preview_link)
    @group.book = @book
    @group.save
    @note = Note.new(group_id: @group.id, pagenumber: 1, body: "This is an example of what a note looks like. Start writing notes to each other using the form below!", user_id: current_user.id)
    @note.save
    @request = Request.new(requester_id: current_user.id, requested_id: params[:newuser], group_id: @group.id, status: false)
    @request.save
    redirect_to root_url
  end

  def searchbooks
    @sbooks = GoogleBooks.search(params[:query], {:api_key => 'AIzaSyAs8X56EGpdbQnW5WswlTNcItzLZGP7uLI', :count => 30, :country => 'us'})
  end

  def displayusersearch
    
  end

  def searchusers
     @susers = User.where(nil) # creates an anonymous scope
     @susers = @susers.starts_with(params[:starts_with]) if params[:starts_with].present?
     @group = Group.new
     @isbn = params[:isbn]
  end

  def displaybooksearch
  end
  
  def show
    @group = Group.find(params[:id])
    @note = Note.new
    @notes = @group.notes.all
    if Note.where(user_id: current_user.id).count > 0
      last_page_read = Note.where(group_id: params[:id], user_id: current_user.id).order('pagenumber DESC').first.pagenumber
    else
      last_page_read = 0
    end

    respond_to do |format|
    format.html # show.html.erb
    format.json { render json: json_out = {
        "timeline"=>
        {
          "headline"=> @group.book.title,
          "type"=>"default",
          "text"=> (@group.users.count < 2 ? " " : ("With " + @group.users.where.not(id: current_user.id).first.name)),

          "asset" => {
              "media" => " ",
              "credit" => " ",
              "caption" => "<img src='" + @group.book.imagelinklarge + "'>"
          },

          "date"=> @notes.map { |note| {"startDate" => note.pagenumber.to_s,
                                        "endDate" => note.pagenumber.to_s,
                                        "text" => note_display(note, last_page_read),
                                        "headline" => User.find(note.user_id).name,
                                        "asset" => {"media" => " ", "thumbnail" => User.find(note.user_id).image}}}

        }
      } }
    end
  end

  def list
    @group = Group.find(params[:id])
    @note = Note.new
  end

  def finish_book
    current_group = Group.find(params[:group])
    current_group.update_attributes(status: false)
    redirect_to groups_user_path(current_user)
  end

  private
    def note_display(note, last_page_read)
      if note.pagenumber <= last_page_read
        note.body
      else
        "Read further to unlock this note!"
      end
    end
  # def group_params
  #   params.require(:group).permit(:users, :book)
  # end
end
