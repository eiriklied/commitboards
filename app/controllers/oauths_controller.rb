# app/controllers/oauths_controller.rb
class OauthsController < ApplicationController
  skip_before_filter :require_login

  # sends the user on a trip to the provider,
  # and after authorizing there back to the callback url.
  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    begin
      if @user = login_from(provider)
        redirect_to root_url
      else
        # sorcery creates the user without running validations
        # but we need to set an email which github doesnt return
        # on the suerinfo call sorcery uses.
        @user = create_from(provider)
        # now we need to fetch the email to get a valid user
        @user.update(email: fetch_email)
        # protect from session fixation attack
        reset_session
        auto_login(@user, true)
        redirect_to root_path, notice: 'Logged in!'
      end
    rescue Exception => e
      logger.error e.message
      e.backtrace.each_with_index{ |line, i| logger.error line if i < 15}

      redirect_to root_path, alert: "Could not log you in #{provider.titleize}!"
    end
  end

  private
  def fetch_email
    client = Octokit::Client.new(:access_token => @access_token.token)
    # [
    #    {:email=>"email.1@bla.com", :primary=>false, :verified=>true},
    #    {:email=>"email.2@bla.com", :primary=>true, :verified=>true}
    # ]
    email = client.get('user/emails', accept: 'application/vnd.github.v3+json').
            select{|e| e.primary && e.verified }.
            first.email
  end

end
