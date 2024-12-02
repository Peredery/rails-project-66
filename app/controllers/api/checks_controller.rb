# frozen_string_literal: true

class Api::ChecksController < Api::ApplicationController
  before_action :check_github_secret_token

  def create
    check = repository.checks.build

    if check.save
      Repository::CheckJob.perform_later(check_id: check.id)

      head :ok
    else
      head :not_found
    end
  end

  def repository
    @repository ||= Repository.find_by(github_id: params.dig(:repository, :id))
  end
end
