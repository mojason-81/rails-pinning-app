class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
  	@user ||= User.where("id=?", session[:user_id]).first
    #@user ||= User.find_by_id!(session[:user_id])
  end
  helper_method :current_user

  def require_login
    if current_user.nil?
      #redirect_to "/login"
      redirect_to login_path
    end
  end
  helper_method :require_login

  def logged_in?
    !current_user.nil? && !current_user.id.nil?
  end
  helper_method :logged_in?

  def user_boards
    @user = current_user
    @boards = Board.where("user_id=?", session[:user_id])
  end
  helper_method :user_boards

  def board_pinnings
    @pinnings = Pinning.where("board_id=?", 1) #need to figure out how to select desired board id number
  end #need to figure out how to get pin names to board show view
  helper_method :board_pinnings

  def pin_title
    @id = Pinning.pin_id
    @title = ''
    @pinning_ids = []
    @pinnings.each do |pinnng|
      @pinning_ids << pinning.pin_id
    end
    return @pinning_ids
  end
end
