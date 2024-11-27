# frozen_string_literal: true

class Repository::CheckMailer < ApplicationMailer
  def notify_status_to_user
    @check = params[:check]
    @user = params[:check].repository.user
    mail(to: @user.email, subject: t('.status', repo_name: @check.repository.name))
  end
end
