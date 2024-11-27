# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('APP_MAIL', 'robot@example.com')
  layout 'mailer'
end
