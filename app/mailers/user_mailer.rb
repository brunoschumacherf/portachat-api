class UserMailer < ApplicationMailer
  def welcome_email(user, password)
    @password = password
    @user = user
    mail(to: @user.email, subject: 'Bem-vindo ao PortaChat!')
  end
end
