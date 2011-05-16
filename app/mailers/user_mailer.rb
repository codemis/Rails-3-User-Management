class UserMailer < ActionMailer::Base
  # TODO fix on production deployment
  default :from => "no-reply@localhost"

  # User.after_create
  #
  def new_user_email(user)
    @user = user
    mail(
      :to => @user.email,
      :subject => "Your user account for our Application"
    )
  end
end
