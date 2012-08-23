class StoriesController < ApplicationController 
  include TinymceFilemanager
  before_filter :require_admin, :except => [:show]
  before_filter :clean_images, :only => [:create, :update]
  #before_filter :require_admin, :only => [:new, :create]
  #before_filter :make_images, :only => [:create]
  def index
    @stories = Story.all
    @new_comment = Comment.new
    unless @user.nil?
      @new_comment.name = @user.name
      @new_comment.email = @user.email
    end
  end
  def show
    @story = Story.find(params[:id])
    @new_comment = Comment.new
    unless @user.nil?
      @new_comment.name = @user.name
      @new_comment.email = @user.email
    end
    render :layout => 'pages'
  end
  def new
    binding.pry
    @story = Story.new
  end
  def create
    begin
      @story = Story.new(params[:story])
    rescue CarrierWave::IntegrityError
      params[:story][:blog_images] = nil
      @story = Story.new(params[:story])
      flash[:notice] = "Invalid image file"
      return render :new
    end  
    if @story.valid?
      @story.save
      redirect_to stories_path, :notice => "Post saved"       
    else
      flash[:notice] = "Invalid data"
      render 'new'
    end 
  end
  def edit
    @story = Story.find(params[:id])
  end
  
  def update
    @story = Story.find(params[:id])
    begin
      @story.write_attributes(params[:story])
    rescue CarrierWave::IntegrityError
      params[:story][:blog_images] = nil
      @story = Story.new(params[:story])
      flash[:notice] = "Invalid image file"
      return render :edit
    end
    if @story.valid?
      @story.save
      redirect_to stories_path
    else
      flash[:notice] = "Invalid data"
      render 'edit'
    end  
  end
  
  def destroy
    @story = Story.find(params[:id])
    @story.delete
    redirect_to stories_path
  end
  
  private
  def clean_images
    params[:story][:blog_images].delete_if { |key, val| val[:file].nil? && val[:remote_file_url] == "" }
  end
end