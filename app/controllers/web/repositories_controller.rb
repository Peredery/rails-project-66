# frozen_string_literal: true

class Web::RepositoriesController < Web::ApplicationController
  before_action :authenticate_user!

  def index
    @repositories = current_user.repositories.includes(:checks)
  end

  def show
    @repository = current_user.repositories.find(params[:id])

    @checks = @repository.checks.order(created_at: :desc)
  end

  def new
    @repository = current_user.repositories.new

    output = Github::FetchRepositories.run(user: current_user)

    if output.valid?
      @github_repositories = output.result
    else
      flash[:alert] = output.errors.messages[:base].to_sentence
      redirect_to repositories_path
    end
  end

  def create
    output = Repository::Create.run(user: current_user, github_id: repository_params[:github_id])

    if output.valid?
      flash[:notice] = t('.success')
      redirect_to output.result
    else
      flash[:alert] = t('.errors')
      @repository = output
      redirect_to new_repository_path
    end
  end

  def repository_params
    params.require(:repository).permit(:github_id)
  end
end
