class AuthenticateUser
  attr_reader :user, :redirect_url

  def initialize(auth, session)
    @auth = auth.deep_symbolize_keys
    @session = session
  end

  def call
    @user = find_or_initialize_user(@auth)
    @user.save && update_session
  end

  private

  def find_or_initialize_user(auth)
    User.where(provider: auth[:provider], uid: auth[:uid])
      .first_or_initialize(
        credentials(auth[:credentials]).merge(info(auth[:info]))
      )
  end

  def credentials(credentials)
    {
      refresh_token: credentials[:refresh_token],
      access_token:  credentials[:token],
      expires_at:    credentials[:expires_at]
    }
  end

  def info(info)
    {
      name:   info[:name],
      email:  info[:email],
      avatar: info[:image].sub(/\?.*$/, "")
    }
  end

  def update_session
    @session[:user_id] = @user.id
    @redirect_url = (@session[:return_to] || root_path)
    @session[:return_to] = nil
    true
  end
end
