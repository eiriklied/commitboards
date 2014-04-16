class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  force_ssl if: :ssl_configured?

  def ssl_configured?
    !(Rails.env.development? || Rails.env.test?)
  end

  def not_authenticated
    redirect_to root_url, alert: "Your need to #{view_context.link_to 'log in', auth_at_provider_path(:github)}".html_safe
  end
end
