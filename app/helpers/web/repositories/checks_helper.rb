# frozen_string_literal: true

module Web::Repositories::ChecksHelper
  GITHUB_URL = 'https://github.com'

  def github_commit_link(repository, sha)
    "#{GITHUB_URL}/#{repository.full_name}/commit/#{sha}"
  end

  def github_file_link(repository, path, sha)
    "#{GITHUB_URL}/#{repository.full_name}/blob/#{sha}/#{path}"
  end
end
