class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    redirect_to "/auth/google"
  end

  def create
    login = AuthenticateUser.new(request.env["omniauth.auth"], session)

    if login.call
      redirect_to(login.redirect_url)
    else
      redirect_to(:login)
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to(root_url)
  end
end
