class SessionsController < ApplicationController
  def callback
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])

    if user
      session[:user_id] = user.id
      redirect_to root_path, notice: 'logged in successfully.'
    else
      created_user = User.create_with_omniauth(auth)
      session[:user_id] = created_user.id
      redirect_to root_path, notice: 'authenticated and logged in successfully.'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'logged out.'
  end

  def failure
    render text: 'twitter auth failed.'
  end
end
