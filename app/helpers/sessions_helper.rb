module SessionsHelper

	def signed_in?
  	!current_user.nil?
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to root_url, notice: "Please sign in."
    end
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to groups_user_path(current_user) unless current_user == @user
  end

  def member_of_group
    @users = Group.find(params[:id]).users
    redirect_to groups_user_path(current_user) unless @users.include?(current_user)
  end

  def writer_of_note
    @user = User.find(Note.find(params[:id]).user_id)
    redirect_to groups_user_path(current_user) unless current_user == @user
  end

end
