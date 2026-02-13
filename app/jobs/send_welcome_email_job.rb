class SendWelcomeEmailJob < ApplicationJob
  queue_as :default

  def perform(user)
    Rails.logger.info "Welcome email job executed for #{user}"
    #SendWelcomeEmailJob.perform_later(self)
   UserMailer.welcome_email(user).deliver_now
    # Do something later
  end
end
