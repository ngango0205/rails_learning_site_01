class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user &.authenticate params[:session][:password]
      log_in user
      cookies.permanent.signed[:user_id] = user.id
      redirect_to user_home_url
    else
      flash.now[:danger] = t ".invalid_session"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
