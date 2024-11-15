# frozen_string_literal: true

class Web::AuthController < Web::ApplicationController
  def callback
    auth_params = request.env['omniauth.auth']
    user = User::FindOrCreate.run(auth_params:)

    if user.valid?
      sign_in(user.result)
      flash[:notice] = t('login.success')
    else
      flash[:alert] = t('login.failure')
    end

    redirect_to root_path
  end

  def destroy
    sign_out
  end
end
