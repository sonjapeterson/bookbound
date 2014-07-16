class GroupsController < ApplicationController

  autocomplete :user, :name, :extra_data => [:image], :display_value => :show_name_and_image, :select_value => :set_name_as_value

  def new
    @group = Group.new
  end

  def create
    @group = Group.new
    @group.save
    @group.users << current_user
    @book = Book.new(title: params[:group][:book])
    @group.book = @book
    @group.save
    @request = Request.new(requester_id: current_user.id, requested_id: User.find_by(name: params[:group][:users]).id, group_id: @group.id, status: false)
    @request.save
    redirect_to root_url
  end

  def show
    @group = Group.find(params[:id])
    @note = Note.new
    @notes = Note.all    

    respond_to do |format|
    format.html # show.html.erb
    format.json { render json: json_out = {
      "timeline"=>
      {
        "headline"=> @group.book.title,
        "type"=>"default",
        "text"=> "With " + @group.users.where.not(id: current_user.id).first.name,

        "asset" => {
            "media" => "http://www.beaglepuppybreeders.co.uk/userimages/K%20litter.jpg",
            "credit" => "Credit Name Goes Here",
            "caption" => "Caption text goes here"
        },

        "date"=> @notes.map { |note| {"startDate" => note.pagenumber,"endDate" => note.pagenumber, "text" => note.body, "headline" => User.find(note.user_id).name }},

      }
    } }
  end
  end

  private

  # def group_params
  #   params.require(:group).permit(:users, :book)
  # end
end
