# frozen_string_literal: true

class Repository::CheckJob < ApplicationJob
  queue_as :checks

  def perform(check)
    interactor = Repository::PerformLint.run(check:)
    return if interactor.valid?

    check.fail!
    Sentry.capture_message(interactor.errors)
  end
end
