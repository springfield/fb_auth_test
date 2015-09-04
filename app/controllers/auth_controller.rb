class AuthController < ApplicationController

  def login
    if params[:code].nil?
      redirect_to fb_login_page
    else
      store_fb_auth
      redirect_to root_path
    end
  end

  def logout
    session[:fb] = nil
    redirect_to root_path
  end

  private

  def store_fb_auth

    session[:fb] = fb.get_auth_token params[:code]
  end

  def fb_login_page
    "https://www.facebook.com/dialog/oauth?client_id=#{FB[:app_id]}&redirect_uri=#{domain}/login&scope=user_friends"
  end
end
