# frozen_string_literal: true

class Repository::Create < InteractionsBase
  string :github_id
  object :user, class: User

  def to_model
    user.repositories.build
  end

  def execute
    repository = user.repositories.find_or_initialize_by(github_id:)

    unless repository.save
      errors.merge!(repository.errors)
    end

    Repository::UpdateAndSetWebhookJob.perform_later(repository_id: repository.id)

    repository
  end
end
