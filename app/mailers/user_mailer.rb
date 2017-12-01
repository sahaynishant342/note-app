class UserMailer < ApplicationMailer
  default from: "nishant.address@gmail.com"

  def account_created user, activation_link
    @user = user
    @activation_link = activation_link
    mail(to: @user.email, subject: "Noted | Account Created")
  end

end
