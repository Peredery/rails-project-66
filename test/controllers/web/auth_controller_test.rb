# frozen_string_literal: true

require 'test_helper'

module Web
  class AuthControllerTest < ActionDispatch::IntegrationTest
    test 'check github auth' do
      post auth_request_path('github')

      assert_response :redirect
    end

    test 'create' do
      sign_in(users(:one))

      assert_response :redirect
      assert signed_in?
    end

    test 'destroy' do
      sign_in(users(:one))

      delete auth_logout_url

      assert_response :redirect
      assert_nil session[:user_id]
    end
  end
end
