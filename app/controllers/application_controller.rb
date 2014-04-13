class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  force_ssl if: :ssl_configured?

  before_filter :require_login

  def ssl_configured?
    !(Rails.env.development? || Rails.env.test?)
  end
end
