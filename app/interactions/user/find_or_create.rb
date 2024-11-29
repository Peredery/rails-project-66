# frozen_string_literal: true

class User::FindOrCreate < InteractionsBase
  hash :auth_params do
    hash :info do
      string :email
      string :name
    end
    hash :credentials do
      string :token
    end
  end

  def execute
    user = User.find_or_initialize_by(email: auth_params[:info][:email])
    user.nickname = auth_params[:info][:name]
    user.token = auth_params[:credentials][:token]
    user.save

    user
  end
end
