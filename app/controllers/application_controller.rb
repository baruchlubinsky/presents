class ApplicationController < ActionController::Base
  protect_from_forgery
  
    def check_login
    if session[:user_id].nil?
        @user = nil
      else
        @user = User.find(session[:user_id])
      end
    end
    
    def require_admin
      check_login
      if @user.nil? || @user[:admin].nil?
        redirect_to home_path
      end
    end  

end
