class ProductsController < ApplicationController
  before_filter :require_artist, :only => [:new, :create, :edit, :destroy]
  
  def new
    @shop = Shop.find_by_name(params[:shop_id])
    @product = Product.new(:shop => @shop)
  end
  
  def create
    @shop = Shop.find_by_name(params[:shop_id])
    @product = Product.new(params[:product])
    @shop.products << @product
    @shop.save
    redirect_to edit_shop_path(@shop.name)
  end
  
end