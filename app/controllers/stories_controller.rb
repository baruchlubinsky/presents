class StoriesController < ApplicationController 
  #before_filter :require_admin, :only => [:new, :create]
  #before_filter :make_images, :only => [:create]
  def index
    @stories = Story.all
  end
  def show
    @story = Story.find(params[:id])
  end
  def new
    @story = Story.new
  end
  def create
    @story = Story.new(params[:story])
    @story.save
    redirect_to stories_path
  end
  def edit
    @story = Story.find(params[:id])
  end
  def update
    @story = Story.find(params[:id])
    @story.write_attributes(params[:story])
    @story.save
    redirect_to stories_path
  end
end