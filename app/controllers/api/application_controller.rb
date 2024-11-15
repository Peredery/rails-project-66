# frozen_string_literal: true

class Api::ApplicationController < ApplicationController
  skip_before_action :verify_authenticity_token

  def check_github_secret_token
    calculated_signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha256'), ENV.fetch('GITHUB_SECRET_TOKEN', nil), request.raw_post)
    signature_from_request = request.headers['HTTP_X_HUB_SIGNATURE_256'].slice('sha256=')

    head :forbidden until Rack::Utils.secure_compare(calculated_signature, signature_from_request)
  end
end
