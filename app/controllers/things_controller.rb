class ThingsController < ApplicationController
  before_filter :require_admin
  
  def new
    @thing = Thing.new
  end
  
  def create
    @thing = Thing.new(params[:thing])
    @thing.save
    redirect_to things_path
  end
  
  def index
    @things = Thing.all
  end
  
  
  
  def
  
end