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
      redirect_to home_path
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