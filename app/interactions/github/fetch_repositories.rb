# frozen_string_literal: true

class Github::FetchRepositories < InteractionsBase
  object :user, class: User

  def execute
    repositories = ApplicationContainer.resolve(:github_client).new(user:).repositories
    filtered_repositories = repositories.each_with_object([]) do |repo, result|
      if repo[:language]&.downcase&.in?(Repository.language.values)
        result << Repository.new({ github_id: repo[:id], name: repo[:name] })
      end
    end

    return errors.add(:base, :empty_repos) if filtered_repositories.empty?

    filtered_repositories
  end
end
