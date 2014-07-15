class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new
    @group.save
    @group.users << current_user
    # @group.book << params[:book]
    @group.save
    @request = Request.new(requester_id: current_user.id, requested_id: params[:group][:users], group_id: @group.id)
    @request.save
    redirect_to root_url
  end

  private

  # def group_params
  #   params.require(:group).permit(:users, :book)
  # end
end