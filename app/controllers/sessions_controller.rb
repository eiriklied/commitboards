class SessionsController < ApplicationController
  def new
    if params[:board_id].present?
      # hook into sorcerys method for redirecting back
      session[:return_to_url] = board_url(params[:board_id])
    end

    redirect_to auth_at_provider_url(:github)
  end

  def destroy
    logout
    redirect_to root_url, notice: 'Logged out :)'
  end
end
