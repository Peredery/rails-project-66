# frozen_string_literal: true

class Repository::UpdateAndSetWebhookJob < ApplicationJob
  queue_as :repositories

  def perform(repository_id:)
    repository = Repository.find(repository_id)

    github_client = ApplicationContainer.resolve(:github_client).new(user: repository.user)
    repo_from_github = github_client.find_repository(github_id: repository.github_id)
    updated_attrs = repo_from_github.attributes.merge(repository.attributes.compact)
    repository.update(updated_attrs)
    github_client.create_hook(full_name: repository.full_name)
  end
end
