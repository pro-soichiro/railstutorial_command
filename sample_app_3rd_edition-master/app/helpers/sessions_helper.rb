module SessionsHelper

  # Logs in the given user.
  def log_in(user) # 関数定義
    session[:user_id] = user.id
  end

  # Remembers a user in a persistent session.
  def remember(user) # 関数定義
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Returns true if the given user is the current user.
  def current_user?(user) # 関数定義
    user == current_user
  end

  # Returns the current logged-in user (if any).
  def current_user # 関数定義
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in? # 関数定義
    !current_user.nil?
  end

  # Forgets a persistent session.
  def forget(user) # 関数定義
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Logs out the current user.
  def log_out # 関数定義
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # Redirects to stored location (or to the default).
  def redirect_back_or(default) # 関数定義
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location # 関数定義
    session[:forwarding_url] = request.url if request.get?
  end
end
