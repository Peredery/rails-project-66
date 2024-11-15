# frozen_string_literal: true

class RepositoryPolicy < ApplicationPolicy
  def new?
    user_is_owner?
  end

  def show?
    user_is_owner?
  end

  def create?
    user_is_owner?
  end

  private

  def user_is_owner?
    user.id == record.user_id
  end
end
