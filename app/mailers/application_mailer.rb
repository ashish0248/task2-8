class ApplicationMailer < ActionMailer::Base
   default from:     "ashish_dmm",
          bcc:      "ashish.dmmwebcamp@gmail.com",
          reply_to: "ashish.dmmwebcamp@gmail.com"
  layout 'mailer'
end
