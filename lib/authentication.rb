# You can also restrict unregistered users from accessing a controller using
# a before filter. For example.
# 
#   before_filter :login_required, :except => [:index, :show]
#
module Authentication
  def self.included(controller)
    controller.send :helper_method, 
      :current_user, :logged_in?, 
      :login_required, :logout_required,
      :redirect_to_target_or_default
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def logged_in?
    current_user
  end

  def login_required
    unless logged_in?
      flash[:error] = "Zaloguj się by mieć dostęp do tej strony."
      store_target_location
      redirect_to login_url
    end
  end

  def logout_required
    if logged_in?
      store_target_location
      flash[:notice] = "Musisz się wylogować by mieć dostęp do tej strony."
      redirect_to root_url
      return false
    end
  end

  def redirect_to_target_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  private

  def store_target_location
    session[:return_to] = request.fullpath
  end
end
