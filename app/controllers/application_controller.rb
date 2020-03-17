class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

 private def current_user
   if session[:user_id]
     @current_user ||= User.find_by(id: session[:user_id])
   elsif cookies.signed[:user_id]
     user = User.find_by(id: cookies.signed[:user_id])
     if user && user.authenticated?(:remember, cookies[:remember_token])
       log_in user
       @current_user = user
     end
   end
 end
 helper_method :current_user
end
