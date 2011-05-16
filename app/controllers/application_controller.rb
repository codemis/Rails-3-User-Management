class ApplicationController < ActionController::Base
  protect_from_forgery
  
  # authlogic
  #
  helper_method :current_user_session, :current_user
  # filter_parameter_logging :password, :password_confirmation # deprecated, use config/application.rb

  # declarative_authorization
  #
  before_filter :set_current_user
  filter_access_to :all
  
  private
    # authlogic
    #
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end

    # declarative_authorization
    #
    def set_current_user
      Authorization.current_user = current_user
    end

    protected
    
      def permission_denied
        flash[:error] = "Sorry, you are not allowed to access that page."
        redirect_to '/'
      end
end
