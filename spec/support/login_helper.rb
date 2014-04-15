module LoginHelper

  def stub_login!(user_data)
    # Stub '#login_at' in '/oauth/:provider'
    override_once(OauthsController, :oauth) do |provider|
      redirect_to action: :callback, provider: provider
    end

    # Stub `#login_from` in '/oauth/callback'
    override_once(OauthsController, :callback) do |provider|
      user = User.find_or_create_by! user_data
      auto_login(user)
      redirect_to root_path
    end
  end

  def login_as(user_data = {})
    user_data = {email: 'john@doe.com', name: 'John Doe'}.merge(user_data)

    stub_login!(user_data)
    visit auth_at_provider_path(:github)
    @current_user = User.find_by!(email: user_data[:email])
  end

  def override_once(receiver, method_name, &block)
    original_method = receiver.instance_method(method_name)
    receiver.send(:define_method, method_name) do |*args|
      value = instance_exec(*args, &block)
      receiver.send(:define_method, method_name) do |*args|
        original_method.bind(self).call(*args)
      end
      value
    end
  end

end
