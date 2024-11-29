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
                       id: '123',
                       ssh_url: 'git@github.com:stubbed_user/stubbed_ruby.git'
                     }),
      Repository.new({
                       name: 'stubbed_javascript',
                       user_id: @user.id,
                       full_name: 'stubbed_user/stubbed_javascript',
                       clone_url: 'https://github.com/stubbed_user/stubbed_javascript.git',
                       id: '345',
                       ssh_url: 'git@github.com:stubbed_user/stubbed_javascript.git'
                     })
    ]
  end

  def find_repository(github_id:)
    repositories.find { |repo| repo.id.to_s == github_id.to_s }
  end

  def create_hook(_repo)
    true
  end
end
