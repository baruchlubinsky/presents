class PresentsController < ApplicationController
  #require_admin
  def new
    @present = Present.new
  end
  
  def create
    @present = Present.new(params[:present])
    @present.save
  end
  
  def show
    @present = Present.find(params[:id])
  end
end