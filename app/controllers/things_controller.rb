class ThingsController < ApplicationController
  before_filter :require_admin, :except => [:show]
  respond_to :html, :json
  
  def new
    @thing = Thing.new
  end
  
  def create
    begin
      @thing = Thing.new(params[:thing])
    rescue CarrierWave::IntegrityError
      return redirect_to new_thing_path, notice: "Invalid image file"
    end  
    if @thing.valid?
      @thing.save
      redirect_to things_path
    else
      render 'new', notice: "Invalid data" 
    end
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