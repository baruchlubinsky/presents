class CommentsController < ApplicationController
  before_filter :require_admin, :only => :destroy
  
  def create
    @comment = Comment.new(params[:comment])
    @comment.fix_url
    @story = Story.find(params[:story_id])
    if @comment.valid?
      @story.comments << @comment
      @comment.save
      @story.save
    
      message = CommentNotification.new_comment @comment
      message.deliver
    
      redirect_to story_path(@story, :anchor => 'comments')
    else
      @story
      render @story, :anchor => 'comments'
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.delete
    redirect_to edit_story_path(params[:story_id])
  end
  
end