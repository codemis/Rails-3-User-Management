class UserSessionsController < ApplicationController
  # get /login
  #
  def new
    if current_user_session
      redirect_to users_path
    else
      @user_session = UserSession.new
    end
  end

  # post /login
  #
  def create
    @user_session = UserSession.new params[:user_session]
    if @user_session.save
      redirect_to dashboard_path
    else
      render :action => "new"
    end
  end

  # delete /logout
  #
  def destroy
    if current_user_session
      current_user_session.destroy
      flash[:notice] = "You have been successfully logged out"
    end
    redirect_to '/'
  end
end
