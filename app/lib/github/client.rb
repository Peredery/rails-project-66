# frozen_string_literal: true

class Github::Client
  def initialize(user:)
    @user = user
    @client = Octokit::Client.new(access_token: @user.token, auto_paginate: true)
  end

  def repositories
    Rails.cache.fetch("github/repositories/#{@user.cache_key_with_version}", expires_in: 5.minutes) do
      repos = @client.repos.select do |repo|
        repo[:language]&.downcase.in?(Repository.language.values)
      end

      repos.map do |repo|
        Repository.new(
          github_id: repo[:id],
          name: repo[:name],
          language: repo[:language].downcase,
          full_name: repo[:full_name],
          clone_url: repo[:clone_url],
          ssh_url: repo[:ssh_url],
          user_id: @user.id
        )
      end
    end
  end

  def find_repository(github_id:)
    repositories.find { |repo| repo.github_id == github_id }
  end

  def create_hook(full_name:)
    @client.create_hook(
      full_name,
      'web',
      {
        url: 'https://1c2d-164-92-141-20.ngrok-free.app/api/checks',
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
