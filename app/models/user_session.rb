class UserSession < Authlogic::Session::Base
  authenticate_with User
  generalize_credentials_error_messages true
end
