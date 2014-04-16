class WelcomeController < ApplicationController
  skip_before_filter :require_login

  def index
    redirect_to dashboard_url if logged_in?
  end
end
