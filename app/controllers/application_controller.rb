class ApplicationController < ActionController::Base
 include Authentication
  protect_from_forgery
 helper_method :singular_class_name

  def require_user_admin
    if current_user.role_type =='admin'
    else
    flash[:notice] = "Brak praw administratora by mieć dostęp do tej strony"
    redirect_to root_url
    return false
    end
  end
   def require_user
      if !logged_in?
        flash[:notice] = "Dostęp wymaga zalogowania się."
        redirect_to root_url  
      end
  end
end
