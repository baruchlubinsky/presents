class UsersController < ApplicationController
  before_filter :force_login, :only => [:edit, :update]
    
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.valid?
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
    else
      flash
  end
  
  def edit
    if params[:id].to_s != session[:user_id].to_s
      render "Illegal operation"
    else
      @user = User.find(session[:user_id])
    end
  end
  
  def update
    @user = User.find(params[:id])
    if params[:user][:admin]
      render "Illegal operation"
    else
      @user.write_attributes(params[:user])
      @user.save
      redirect_to home_path
    end
  end
  
  def index
    @users = User.all
  end
end