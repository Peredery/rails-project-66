# frozen_string_literal: true

require 'test_helper'

class Api::ChecksControllerTest < ActionDispatch::IntegrationTest
  test 'should create new' do
    repository = repositories(:two)
    body = "repository[id]=#{repository.github_id}"
    x_hmac = calculate_x_hmac(body)
    params = { repository: { id: repository.github_id } }
    before_check_count = repository.checks.count

    post(api_checks_url, headers: { 'HTTP_X_HUB_SIGNATURE_256' => x_hmac }, params:)
    assert_response :success
    assert { repository.checks.count == before_check_count + 1 }
    assert { repository.checks.last.finished? }
  end
end
