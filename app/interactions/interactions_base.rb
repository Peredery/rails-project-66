# frozen_string_literal: true

class InteractionsBase < ActiveInteraction::Base
  include Pundit::Authorization
end
