class StaticPagesController < ApplicationController
	def index
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
