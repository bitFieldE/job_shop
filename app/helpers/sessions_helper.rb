module SessionsHelper

  def log_in(user)
    session[:user_id] = user.id
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def user_log_in?
    !current_user.nil?
  end

  def log_out
   session.delete(:user_id)
   @current_user = nil
  end
end
