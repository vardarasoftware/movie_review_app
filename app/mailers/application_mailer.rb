class ApplicationMailer < ActionMailer::Base
  default from: "movie@review.com"
  layout "mailer"
end
