# frozen_string_literal: true

class Repository::CheckJob < ApplicationJob
  queue_as :checks

  def perform(check)
    interactor = Repository::PerformLint.run(check:)

    Repository::CheckMailer.with(check:).notify_status_to_user.deliver_later if interactor.valid?
  end
end
