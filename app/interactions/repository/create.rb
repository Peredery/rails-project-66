# frozen_string_literal: true

class Repository::Create < InteractionsBase
  string :github_id
  object :user, class: User

  validate :valid_github_id

  def to_model
    user.repositories.build
  end

  def execute
    repository = user.repositories.find_or_initialize_by(github_id:)

    unless repository.save
      errors.merge!(repository.errors)
    end

    repository
  end

  def valid_github_id
    ApplicationContainer.resolve(:github_client).new(user:).find_repository(github_id:).present?
  end
end
