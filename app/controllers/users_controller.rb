class UsersController < ApplicationController
  helper_method :sort_column, :sort_direction
  
  # filters
  #
  filter_resource_access
  
  # get all users
  #
  def index
    @users = User.order(sort_column+" "+sort_direction)
  end
  
  # show an individual user
  #
  def show
  end
  
  # create a new user form
  #
  def new
    @user = User.new :role_attributes => {:title => 'member'}
  end
  
  # create a new user processor
  #
  def create
    @user = User.new params[:user]
    if @user.save
      flash[:notice] = "#{@user.full_name} was successfully added."
      redirect_to users_path
    else
      render :action => :new
    end
  end
  
  # update a current user form
  #
  def edit
  end
  
  # update a current user processor
  #
  def update
    if @user.update_attributes params[:user]
      if @user.id == current_user.id
        flash[:notice] = "Your account was successfully updated."
      else
        flash[:notice] = "#{@user.full_name} account was successfully updated."
      end
      if current_user.administrator?
        redirect_to users_path
      else
        redirect_to dashboard_path
      end
    else
      render :action => :edit
    end
  end
  
  # Remove a user account
  #
  def destroy
    current_full_name = @user.full_name
    if @user.destroy
      flash[:notice] = "#{current_full_name} account was successfully removed."
      redirect_to users_path
    else
      render :action => :index
    end 
  end
  
  private
    # column to sort by
    #
    def sort_column
      User.column_names.include?(params[:sort]) ? params[:sort] : "login"
    end
    
    # direction to sort in
    #
    def sort_direction
      %w[asc, desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
    

end
