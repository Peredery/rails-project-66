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

    github_id = 123

    Repository.find_by(github_id:).destroy

    post repositories_path, params: { repository: { github_id: } }

    assert { Repository.exists?(github_id:) }

    assert_redirected_to repository_url(Repository.find_by(github_id:))
  end
end
