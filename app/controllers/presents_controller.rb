class PresentsController < ApplicationController
  #require_admin
  def new
    @present = Present.new
  end
  
  def create
    @present = Present.new(params[:present])
    @present.save
    redirect_to '/admin', :notice => 'Successfully created a new present'
  end
  
  def show
    @present = Present.find(params[:id])
  end
end