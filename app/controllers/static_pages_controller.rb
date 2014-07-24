class StaticPagesController < ApplicationController
  before_filter :disable_footer, only: [:index]

	def index
    if !current_user.nil?
      redirect_to groups_user_path(current_user)
    end
	end

  def invite
  end

  def sendinvite
    @address = params[:address]
    InviteMailer.welcome_email(@address).deliver
    flash[:notice] = "Email sent!"
    redirect_to root_path
  end
end
