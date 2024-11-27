# frozen_string_literal: true

unless Rails.env.test?
  Rails.application.configure do
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      user_name: ENV.fetch('SMTP_USERNAME', nil),
      password: ENV.fetch('SMTP_PASSWORD', nil),
      address: ENV.fetch('SMTP_ADDRESS', 'localhost'),
      host: ENV.fetch('SMTP_HOST', 'localhost'),
      port: ENV.fetch('SMTP_PORT', '2525'),
      authentication: :login
    }
  end
end
