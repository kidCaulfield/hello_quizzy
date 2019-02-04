class ApplicationMailer < ActionMailer::Base
  default from: 'hello.quizzy.mailer@gmail.com'
  layout 'mailer'
end
