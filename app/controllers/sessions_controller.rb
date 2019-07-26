# frozen_string_literal: true

##
# Sessions Controller.
# This file is hnadling authentication using Github and Github's connected apps.
#
class SessionsController < ApplicationController
  def new; end

  def create
    auth = request.env['omniauth.auth']
    user = find_or_create_user(auth)

    reset_session
    session[:user_id] = user.id
    session[:token] = auth['credentials']['token']
    redirect_to root_url, notice: 'Signed in!'
  end

  def destroy
    reset_session
    redirect_to signin_path, notice: 'Signed out!'
  end

  def failure
    redirect_to signin_path, alert: "Authentication error: #{params[:message].humanize}"
  end

  private

  def find_or_create_user(auth)
    user = User.where(provider: auth['provider'], uid: auth['uid'].to_s).first
    user || User.create_with_omniauth(auth)
  end
end
