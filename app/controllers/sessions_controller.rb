class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user && user&.authenticate(params[:password])
      if user.activated?
        log_in user
        params[:remember_me] == '1' ? remember(user) : forget(user)
        redirect_to user
      else
        message  = "アカウントが有効化されていません"
        message += "メールに記載されたリンクにアクセスしてカウントを有効化してください"
        flash[:alert] = message
        redirect_to :root
      end
    else
      flash.alert = "メールアドレスとパスワードが一致しません"
    end
  end

  def destroy
    log_out
    redirect_to :root
  end
end
