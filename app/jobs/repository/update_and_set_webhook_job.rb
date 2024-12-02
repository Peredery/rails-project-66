# frozen_string_literal: true

class Repository::UpdateAndSetWebhookJob < ApplicationJob
  queue_as :repositories

  def perform(repository_id:)
    Repository::Update.run!(repository_id:)
  end
end
