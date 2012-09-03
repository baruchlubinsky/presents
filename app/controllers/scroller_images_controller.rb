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
    @scroller_image = ScrollerImage.new(params[:scroller_image])
    @scroller_image.save
    redirect_to scroller_images_path
  end
  
  def update
    @scroller_image = ScrollerImage.find(params[:id])
    @scroller_image.write_attributes(params[:scroller_image])
    @scroller_image.save
    redirect_to scroller_images_path
  end
  
  def destroy
    @scroller_image = ScrollerImage.find(params[:id])
    @scroller_image.delete
    redirect_to scroller_images_path
  end
  
end