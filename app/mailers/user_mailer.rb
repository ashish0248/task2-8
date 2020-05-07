class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.registration_confirmation.subject
  #
  def welcome_mail(user)
    mail(
    from: 'ashish.dmmwebcamp@gmail.com',
    to:   user.email,
  )
  end
end
