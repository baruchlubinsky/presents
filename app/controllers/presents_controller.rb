class PresentsController < ApplicationController
  before_filter :require_admin
  def new
    @present = Present.new
  end
  
  def index
    @presents = Present.all
  end
  
  def create
    @present = Present.new(params[:present])
    @present.save
    redirect_to '/admin', :notice => 'Successfully created a new present'
  end
  
  def update
    @present = Present.find(params[:id])
    @present.write_attributes(params[:present])
    @present.save
    redirect_to presents_path
  end
  
  def show
    @present = Present.find(params[:id])
  end
  
  def destroy
    @present = Present.find(params[:id])
    @present.delete
    redirect_to presents_path
  end
end