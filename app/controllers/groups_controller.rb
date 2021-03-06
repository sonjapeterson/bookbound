class GroupsController < ApplicationController
  helper_method :note_display, :find_last_page_read

  include GroupsHelper

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

    @books = GoogleBooks.search(params[:isbn], {:api_key => 'AIzaSyAs8X56EGpdbQnW5WswlTNcItzLZGP7uLI', :country => 'US'})

    chosenbook = @books.first
    @book = Book.new(title: chosenbook.title, author: chosenbook.authors, publisher: chosenbook.publisher, datepublished: chosenbook.published_date, pagecount: chosenbook.page_count, summary: chosenbook.description, imagelinklarge: chosenbook.image_link, imagelinksmall: chosenbook.image_link, previewlink: chosenbook.preview_link)

    # if @book.pagecount.nil?
    #   @book.pagecount = 1000
    # end
    
    @group.book = @book
    @group.save
    @note = Note.new(group_id: @group.id, pagenumber: 1, body: "This is an example of what a note looks like. Start writing notes to each other by clicking 'Add a Note\' above!", user_id: current_user.id)
    @note.save
    @request = Request.new(requester_id: current_user.id, requested_id: params[:newuser], group_id: @group.id, status: false)
    @request.save

    notification = User.find_by(id: @request.requested_id).notifications.build(read: false, content: User.find_by(id: @request.requester_id).fname + " has requested to read with you", destination: "request", group: @group.id)
    notification.save

    redirect_to groups_user_path(current_user)
  end

  def searchbooks
    @sbooks = GoogleBooks.search(params[:query], {:api_key => 'AIzaSyAs8X56EGpdbQnW5WswlTNcItzLZGP7uLI', :count => 30, :country => 'US'})
  end

  def searchusers
     @book = GoogleBooks.search(params[:isbn], {:api_key => 'AIzaSyAs8X56EGpdbQnW5WswlTNcItzLZGP7uLI', :country => 'US'}).first
     @susers = User.starts_with(params[:starts_with].downcase) if params[:starts_with].present?
     @randos = find_matching_users
     @group = Group.new
     @isbn = params[:isbn]
  end

  def show
    @group = Group.find(params[:id])
    @note = Note.new
    @notes = @group.notes.all
    last_page_read = find_last_page_read

    respond_to do |format|
    format.html # show.html.erb
    format.json { render json: json_out = {
        "timeline"=>
        {
          "headline"=> "<a href='" + "/books/" + @group.book.id.to_s + "'>" + @group.book.title + "</a>",
          "type"=>"default",
          "text"=> (@group.users.count < 2 ? " " : ("with " + @group.users.where.not(id: current_user.id).first.name)),

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

    partner = current_group.users.where.not(id: current_user.id)[0]
    notification = partner.notifications.build(read: false, content: partner.fname + " has marked " + current_group.book.title + " as finished ", destination: "note", group: current_group.id)
    notification.save

    redirect_to groups_user_path(current_user)
  end

  private
    def note_display(note, last_page_read)
      if note.pagenumber <= last_page_read || @group.status == false
        return note.body
      else
        return "Read further to unlock this note!"
      end
    end

    def find_last_page_read
      if Note.where(user_id: current_user.id, group_id: params[:id]).count > 0
        return Note.where(group_id: params[:id], user_id: current_user.id).order('pagenumber DESC').first.pagenumber
      else
        return 0
      end
    end
end
