# frozen_string_literal: true

class ApplicationContainer
  extend Dry::Container::Mixin

  if Rails.env.test?
    register :github_client, -> { Github::ClientStubbed }
    register :open3, -> { Open3Stubbed }
  else
    register :github_client, -> { Github::Client }
    register :open3, -> { Open3 }
  end
end
