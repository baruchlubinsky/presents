class PresentProductsController < ApplicationController
  before_filter :require_admin
  
  def index
    @new_present = PresentProduct.new
    @presents = PresentProduct.all
  end
  
  def create
    @present = PresentProduct.new(params[:present_product])
    @present.save
    redirect_to present_products_path
  end
  
  def update
    @present = PresentProduct.find(params[:id])
    @present.update_attributes(params[:present_product])
    redirect_to present_products_path
  end
  
  def destroy
    @present = PresentProduct.find(params[:id])
    @present.delete
    redirect_to present_products_path
  end
  
end