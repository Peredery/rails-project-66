# frozen_string_literal: true

class Github::Client
  include Rails.application.routes.url_helpers

  def initialize(user:)
    @user = user
    @client = Octokit::Client.new(access_token: @user.token, auto_paginate: true)
  end

  def repositories
    Rails.cache.fetch("github/repositories/#{@user.cache_key_with_version}", expires_in: 5.minutes) do
      @client.repos
    end
  end

  def find_repository(github_id:)
    cached_repos = Rails.cache.read("github/repositories/#{@user.cache_key_with_version}")
    found_repo = cached_repos&.find { |r| r.id == github_id }

    found_repo || @client.repo(github_id.to_i)
  end

  def create_hook(full_name:)
    @client.create_hook(
      full_name,
      'web',
      {
        url: api_checks_url,
        content_type: 'json',
        secret: ENV.fetch('GITHUB_SECRET_TOKEN', nil)
      },
      {
        event_type: ['push'],
        active: true
      }
    )
  end
end
