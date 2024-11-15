# frozen_string_literal: true

require 'test_helper'

class Api::ChecksControllerTest < ActionDispatch::IntegrationTest
  test 'should get create' do
    get api_checks_create_url
    assert_response :success
  end
end
