class SessionsController < ApplicationController
  def new
    redirect_to auth_at_provider_url(:github)
  end

  def destroy
    logout
    redirect_to root_url, notice: 'Logged out :)'
  end
end
