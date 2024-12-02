# frozen_string_literal: true

class Repository::CheckJob < ApplicationJob
  queue_as :checks

  def perform(check_id:)
    check = Repository::Check.find(check_id)

    interactor = Repository::PerformLint.run(check:)

    Sentry.capture_message('Check failed', extra: { check: }) unless interactor.valid?
  end
end
