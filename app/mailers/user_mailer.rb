class UserMailer < ApplicationMailer

  def welcome_user(user)
    @user = user
    mail to: [@user.email], subject: "Welcome to LoveMind, #{@user.username}"
  end
end
