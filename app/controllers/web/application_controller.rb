# frozen_string_literal: true

class Web::ApplicationController < ApplicationController
  include Pundit::Authorization
  include Authentication
end
