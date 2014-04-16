# app/controllers/oauths_controller.rb
class OauthsController < ApplicationController
  skip_before_filter :require_login

  # sends the user on a trip to the provider,
  # and after authorizing there back to the callback url.
  def oauth
    session[:oauth_state] = SecureRandom.hex
    login_at(params[:provider], state: session[:oauth_state])
  end

  def callback
    # validate state param since sorcery doesnt do it..
    validate_state_param!

    provider = params[:provider]
    begin
      if @user = login_from(provider)
        redirect_to dashboard_url, notice: 'Logged in!'
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
        redirect_to dashboard_path, notice: 'Logged in!'
      end
    rescue Exception => e
      logger.error e.message
      e.backtrace.each_with_index{ |line, i| logger.error line if i < 15}

      redirect_to root_path, alert: 'Could not log you in! Did you allow us to get your email from github?'
    end
  end

  private

  def validate_state_param!
    if params[:state].blank? || (session[:oauth_state] != params[:state])
      raise 'Not a valid callback'
    end
    session.delete(:oauth_state)
  end

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
