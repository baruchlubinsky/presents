class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :check_login
  
    def check_login
      if session[:user_id].nil?
        @user = nil
      else
        @user = User.find(session[:user_id])
      end
    end
    
    def require_admin
      #check_login
      if @user.nil? || @user[:admin].nil?
        redirect_to home_path
      end
    end  
  
    def force_login
      #check_login
      if @user.nil?
        if request.path == '/cart/add_present'
          session[:return_path] = '/get_a_present'
        else
          session[:return_path] = request.url
        end
        redirect_to '/login', :notice => 'You must be signed in to place an order.'
      end
    end
    
    def check_artist?
      if @user.nil?
        redirect_to '/login'
        return false
      end
      if (!@user[:admin].nil? || @shop.artists.to_a.include?(@user))
        return true
      end
      redirect_to '/login'
      return false
    end
end
