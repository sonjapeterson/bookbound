class InviteMailer < ActionMailer::Base
  default from: "sonja.peterson@gmail.com"

  def welcome_email(emailto)
    @emailto = emailto
    mail(to: @emailto, subject: 'Do you read?')
  end

end
