class ApplicationController < ActionController::Base
  add_flash_types(:danger) # registers danger as a flash type that can now be used and styled

  private

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    helper_method :current_user

    def require_signin
      unless current_user
        redirect_to new_session_path, alert: "Sign in first"
      end
    end

end
