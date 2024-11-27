# frozen_string_literal: true

class Repository::CheckJob < ApplicationJob
  queue_as :checks

  def perform(check)
    interactor = Repository::PerformLint.run(check:)
    if interactor.valid?
      Repository::CheckMailer.with(check:).notify_status_to_user.deliver_later
    else
      check.fail!
      Sentry.capture_message(interactor.errors)
    end
  end
end
