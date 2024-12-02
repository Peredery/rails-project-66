# frozen_string_literal: true

require 'test_helper'

class Web::Repositories::ChecksControllerTest < ActionDispatch::IntegrationTest
  test 'create check' do
    sign_in(users(:two))

    repository = repositories(:two)
    before_check_count = repository.checks.count

    post repository_checks_url(repository)

    assert_redirected_to repository
    assert { repository.checks.count == before_check_count + 1 }
    assert { repository.checks.last.finished? }
  end

  test 'show check' do
    sign_in(users(:one))

    repository = repositories(:one)

    get repository_check_url(repository, repository.checks.first)
    assert_response :success
  end
end
