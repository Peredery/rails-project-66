# frozen_string_literal: true

class Github::ClientStubbed
  def initialize(user:)
    @user = user
  end

  def repositories
    [
      Repository.new({
                       name: 'stubbed_ruby',
                       user_id: @user.id,
                       full_name: 'stubbed_user/stubbed_ruby',
                       clone_url: 'https://github.com/stubbed_user/stubbed_ruby.git',
                       github_id: '123456789',
                       ssh_url: 'git@github.com:stubbed_user/stubbed_ruby.git'
                     }),
      Repository.new({
                       name: 'stubbed_javascript',
                       user_id: @user.id,
                       full_name: 'stubbed_user/stubbed_javascript',
                       clone_url: 'https://github.com/stubbed_user/stubbed_javascript.git',
                       github_id: '987654321',
                       ssh_url: 'git@github.com:stubbed_user/stubbed_javascript.git'
                     })
    ]
  end

  def find_repository(github_id:)
    repositoreis.find { |repo| repo.id == github_id }
  end
end
