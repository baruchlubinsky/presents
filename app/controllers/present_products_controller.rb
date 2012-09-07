class PresentProductsController < ApplicationController
  before_filter :require_admin
  
  def index
    @new_present = Product.new
    @presents = Product.presents
  end
  
  def create
    @present = Product.new(params[:present_product])
    #binding.pry
    @present[:_type] = 'PresentProduct'
    #binding.pry
    @present.save
    #binding.pry
    redirect_to present_products_path
  end
  
  def update
    @present = Product.find(params[:id])
    @present.update_attributes(params[:present_product])
    redirect_to present_products_path
  end
  
  def destroy
    @present = Product.find(params[:id])
    @present.delete
    redirect_to present_products_path
  end
  
end