# frozen_string_literal: true

# == Schema Information
#
# Table name: repository_checks
#
#  id            :integer          not null, primary key
#  passed        :boolean          default(FALSE)
#  result        :json
#  state         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  commit_id     :string
#  repository_id :integer          not null
#
# Indexes
#
#  index_repository_checks_on_repository_id  (repository_id)
#
# Foreign Keys
#
#  repository_id  (repository_id => repositories.id)
#
require 'test_helper'

class Repository::CheckTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end