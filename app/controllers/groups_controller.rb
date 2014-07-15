class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.save
    redirect_to root_url
  end

  private

  def group_params
    params.require(:group).permit(:users, :book)
  end
end
