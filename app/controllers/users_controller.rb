class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  def create
    @user = User.new(params[:user])
    puts :params['user']
    puts @user
    if @user.save
      session[:user_id] = @user.id
      if session[:return_path].nil?
        redirect_to home_path
      else
        redirect_to session.delete(:return_path)
      end
    else
      flash[:message] = 'Unable to create user'
      redirect_to new_user_path
    end
  end
  def show
    @user = User.find(session[:user_id])
    @users = User.all.to_a
    @users.delete(@user)
  end
  def index
    @users = User.all
  end
end