class AuthorisationsController < ApplicationController
  # Show the login form
  def new
    
  end
  # Sign in
  def create
    query = User.where(:email => params[:email])
    if query.count == 0
      flash[:message] = 'Unable to sign in, email does not exist'
      redirect_to new_authorisation_path
    else
      @user = query.first
      if @user.password_match?(params[:password])
        session[:user_id] = @user.id
        session[:access] = @user.level
        redirect_to home_path
      else 
        flash[:message] = 'Unable to sign in, incorrect password'
        redirect_to new_authorisation_path
      end 
    end 
  end
  # Sign out
  def destroy    
    session[:user_id] = nil
    session[:access] = nil
    redirect_to new_authorisation_path
  end
end