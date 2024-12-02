# frozen_string_literal: true

require 'test_helper'

class Web::RepositoriesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    sign_in(users(:one))

    get repositories_path
    assert_response :success
  end

  test 'should get show' do
    sign_in(users(:one))

    repository = repositories(:one)

    get repository_url(repository)
    assert_response :success
  end

  test 'should not get show' do
    sign_in(users(:one))

    repository = repositories(:two)

    get repository_url(repository)
    assert_response :not_found
  end

  test 'should get new' do
    sign_in(users(:one))

    get new_repository_path
    assert_response :success
  end

  test 'should create repository' do
    sign_in(users(:one))

    github_id = 999

    post repositories_path, params: { repository: { github_id: } }

    created_repo = Repository.find_by(github_id:)

    assert { created_repo }
    assert { created_repo.name == 'stubbed_ruby' }
    assert { created_repo.language == 'ruby' }
    assert_redirected_to repository_url(Repository.find_by(github_id:))
  end
end
