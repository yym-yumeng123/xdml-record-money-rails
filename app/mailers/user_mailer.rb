class UserMailer < ApplicationMailer
  # default from: 'notifications@example.com'

  def welcome_email(user)
    @user = user
    @url  = 'http://yumengYang.com'
    mail(to: @user.email, subject: '欢迎来到 yym 的 世界')
  end
end
