class SessionsController < ApplicationController
  def new
  end

  def create
#    raise request.env["omniauth.auth"].to_yaml
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to root_url
  end

  def redirect
    redirect_to "https://www.yammer.com/dialog/oauth?client_id=kvGDzE1a5A125MtYlVa96g&display=page&redirect_uri=http://localhost:3000/auth/yammer/callback&response_type=token"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end
