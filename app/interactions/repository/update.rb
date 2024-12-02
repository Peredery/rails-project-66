# frozen_string_literal: true

class Repository::Update < InteractionsBase
  integer :repository_id

  def execute
    repository = Repository.find(repository_id)

    client = ApplicationContainer.resolve(:github_client).new(user: repository.user)
    repo = client.find_repository(github_id: repository.github_id)

    repository.update!({
                         name: repo[:name],
                         language: repo[:language].downcase,
                         full_name: repo[:full_name],
                         clone_url: repo[:clone_url],
                         ssh_url: repo[:ssh_url]
                       })

    client.create_hook(full_name: repository.full_name)
  end
end
