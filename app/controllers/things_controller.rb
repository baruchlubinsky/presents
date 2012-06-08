class ThingsController < ApplicationController
  before_filter :require_admin, :except => [:show]
  respond_to :html, :json
  
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
  
  def destroy
    @thing = Thing.find(params[:id])
    @thing.delete
    redirect_to things_path
  end
  
  
  def show
    @thing = Thing.find(params[:id])
    respond_with(@thing)
  end
  
end