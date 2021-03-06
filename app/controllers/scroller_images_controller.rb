class ScrollerImagesController < ApplicationController
  before_filter :require_admin
  
  def index
    @new_scroller_image = ScrollerImage.new
    @scroller_images = ScrollerImage.all
  end
  
  def new
    @scroller_image = ScrollerImage.new
  end
  
  def create
    @new_scroller_image = ScrollerImage.new(params[:scroller_image])
    if @new_scroller_image.valid?
      @new_scroller_image.save
      redirect_to scroller_images_path
    else
      @scroller_images = ScrollerImage.all
      render :index
    end
  end
  
  def update
    @scroller_image = ScrollerImage.find(params[:id])
    @scroller_image.write_attributes(params[:scroller_image])
    if @scroller_image.valid?
      @scroller_image.save
      redirect_to scroller_images_path
    else
      @scroller_images = ScrollerImage.all
      render :index
    end
  end
  
  def destroy
    @scroller_image = ScrollerImage.find(params[:id])
    @scroller_image.delete
    redirect_to scroller_images_path
  end
  
end