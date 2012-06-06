class StoriesController < ApplicationController 
  before_filter :require_admin
  before_filter :clean_images, :only => [:create, :update]
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
  def destroy
    @story = Story.find(params[:id])
    @story.delete
    redirect_to stories_path
  end
  
  private
  def clean_images
    puts params[:story][:blog_images]
    params[:story][:blog_images].delete_if { |key, val| val[:file].nil? && val[:remote_file_url] == "" }
  end
end