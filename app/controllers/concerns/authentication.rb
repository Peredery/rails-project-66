# frozen_string_literal: true

module Authentication
  extend ActiveSupport::Concern

  included do
    helper_method :current_user, :user_signed_in?
  end

  def authenticate_user!
    redirect_to root_path, alert: t('need_login') unless current_user
  end

  def current_user
    Current.user || authenticate_user_from_session
  end

  def user_signed_in?
    current_user.present?
  end

  def authenticate_user_from_session
    User.find_by(id: session[:user_id])
  end

  def sign_in(user)
    Current.user = user
    reset_session
    session[:user_id] = user.id
  end

  def sign_out
    Current.user = nil
    reset_session
  end
end
