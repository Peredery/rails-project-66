# frozen_string_literal: true

# == Schema Information
#
# Table name: repository_checks
#
#  id            :integer          not null, primary key
#  aasm_state    :string
#  passed        :boolean          default(FALSE)
#  result        :json
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
class Repository::Check < ApplicationRecord
  include AASM

  belongs_to :repository, class_name: 'Repository', inverse_of: :checks

  aasm do
    state :pending, initial: true
    state :in_progress
    state :finished
    state :failed

    event :start do
      transitions from: :pending, to: :in_progress
    end

    event :complete do
      transitions from: :in_progress, to: :finished
    end

    event :fail do
      transitions from: :in_progress, to: :failed
    end
  end
end
