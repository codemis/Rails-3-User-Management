class ForgotPasswordController < ApplicationController
  # filters
  #
  before_filter :find_user, :only => [:edit, :update]
   
  # request password reset
  #
  def new
  end
  
  # process request for new password
  #
  def create
    if params[:user][:email].blank?
      flash[:error] = "Your email cannot be blank"
      render :action => "new" and return
    end
    if @user = User.find_by_email(params[:user][:email])
      @user.deliver_reset_password_email
      flash[:notice] = "Please check your email account.  Your password has been reset."
      redirect_to login_path
    else
      flash[:error] = "No account was found with the email you provided"
      render :action => "new"
    end
  end
  
  # Give user ability to reset password
  #
  def edit
  end
  
  # process request to reset password
  #
  def update
    @user.validate_password = true
    if @user.update_attributes params[:user]
      flash[:notice] = "Your password has been reset"
      redirect_to dashboard_path
    else
      render :action => "edit"
    end
  end
  
  private
    # Find a specific user
    def find_user
      @user = User.find_by_perishable_token(params[:id])
    end
end
