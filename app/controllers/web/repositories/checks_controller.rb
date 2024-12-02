# frozen_string_literal: true

class Web::Repositories::ChecksController < ApplicationController
  before_action :authenticate_user!

  def show
    @check = repository.checks.find(params[:id])

    redirect_to repository_path(repository), alert: t('.not_finished') unless @check.finished?
  end

  def create
    check = repository.checks.new

    if check.save
      flash[:notice] = t('.success')
      Repository::CheckJob.perform_later(check)
      redirect_to repository_path(repository)
    else
      flash[:alert] = t('.failure')
      redirect_to repositories_path
    end
  end

  private

  def repository
    @repository ||= current_user.repositories.find(params[:repository_id])
  end
end
