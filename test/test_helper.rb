# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
ENV['GITHUB_SECRET_TOKEN'] = 'secret1'
ENV['BASE_URL'] ||= 'localhost'

require_relative '../config/environment'
require 'rails/test_help'
require 'webmock/minitest'

OmniAuth.config.test_mode = true

module ActiveSupport
  class TestCase
    setup do
      ActiveJob::Base.queue_adapter.perform_enqueued_jobs = true
      ActiveJob::Base.queue_adapter.perform_enqueued_at_jobs = true
    end

    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    def load_fixture(filename)
      File.read(File.dirname(__FILE__) + "/fixtures/#{filename}")
    end
  end
end

module ActionDispatch
  class IntegrationTest
    def sign_in(user, _options = {})
      auth_hash = {
        provider: 'github',
        uid: '12345',
        info: {
          email: user.email,
          name: user.nickname
        },
        credentials: {
          token: user.token
        }
      }

      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash::InfoHash.new(auth_hash)

      get callback_auth_url('github')
    end

    def signed_in?
      session[:user_id].present? && current_user.present?
    end

    def current_user
      Current.user ||= User.find_by(id: session[:user_id])
    end

    def calculate_x_hmac(body)
      hmac = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), ENV.fetch('GITHUB_SECRET_TOKEN', 'secret1'), body)
      "sha256=#{hmac}"
    end
  end
end
