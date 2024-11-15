# frozen_string_literal: true

class Github::FetchRepositories < InteractionsBase
  object :user, class: User

  def execute
    repositories = ApplicationContainer.resolve(:github_client).new(user:).repositories

    errors.add(:base, :empty_repos) if repositories.empty?

    repositories
  end
end
