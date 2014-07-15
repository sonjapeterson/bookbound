class GroupsController < ApplicationController

  autocomplete :user, :name, :extra_data => [:image], :display_value => :display_user_name_and_image

  def new
    @group = Group.new
  end

  def create
    @group = Group.new
    @group.save
    @group.users << current_user
    # @group.book << params[:book]
    @group.save
    @request = Request.new(requester_id: current_user.id, requested_id: User.find_by(name: params[:group][:users]).id, group_id: @group.id)
    @request.save
    redirect_to root_url
  end

  private

  # def group_params
  #   params.require(:group).permit(:users, :book)
  # end
end
