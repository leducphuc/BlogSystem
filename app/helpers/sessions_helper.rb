module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  
  def current_user?(user)
    current_user == user
  end

  def current_user
    @current_user||= User.find_by(id: session[:user_id])
    # if(user_id = session[:user_id])
  #     @current_user||= User.find_by(id: user_id)
  #   elsif(user_id=cookies.signed[:user_id])
  #     user = User.find_by(id:user_id)
  #     if user && user.authenicated?
  end

  def logged_in?
    !current_user.nil?
  end


end
