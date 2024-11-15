# frozen_string_literal: true

module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user_from_session
    protect_from_forgery with: :exception

    helper_method :current_user, :signed_in?

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  end

  def user_not_authorized
    redirect_to request.referer || root_path, alert: t('not_authorized')
  end

  def authenticate_user!
    redirect_to root_path, alert: t('need_login') unless authenticate_user_from_session
  end

  def authenticate_user_from_session
    Current.user ||= User.find_by(id: session[:user_id])
  end

  def current_user
    Current.user
  end

  def signed_in?
    current_user.present?
  end

  def sign_in(user)
    reset_session
    session[:user_id] = user.id
  end

  def sign_out
    reset_session
    redirect_to root_path, notice: t('logout.success')
  end
end
