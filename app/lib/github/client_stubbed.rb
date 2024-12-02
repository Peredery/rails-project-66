# frozen_string_literal: true

class Github::ClientStubbed
  def initialize(user:)
    @user = user
  end

  def repositories
    Rails.root.join('test/fixtures/files/repositories.json').open do |file|
      JSON.parse(file.read).map do |repo|
        Sawyer::Resource.new(Octokit.agent, repo)
      end
    end
  end

  def find_repository(github_id:)
    repositories.find { |repo| repo.id.to_s == github_id.to_s } || repositories.first
  end

  def create_hook(_repo)
    true
  end
end
