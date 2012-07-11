class BlogImagesController < ApplicationController
  before_filter :require_admin
  def destroy
    @story = Story.find(params[:story_id])
    im = @story.blog_images.find(params[:id])
    im.destroy
    @story.save
    redirect_to edit_story_path @story
  end
end