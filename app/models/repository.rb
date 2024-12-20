# frozen_string_literal: true

# == Schema Information
#
# Table name: repositories
#
#  id         :integer          not null, primary key
#  clone_url  :string
#  full_name  :string
#  language   :string
#  name       :string
#  ssh_url    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  github_id  :string
#  user_id    :integer          not null
#
# Indexes
#
#  index_repositories_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Repository < ApplicationRecord
  extend Enumerize

  belongs_to :user
  has_many :checks, class_name: 'Repository::Check', dependent: :destroy

  enumerize :language, in: %i[javascript ruby], default: nil, allow_nil: true
end
