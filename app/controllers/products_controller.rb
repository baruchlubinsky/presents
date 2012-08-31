class ProductsController < ApplicationController
  before_filter :require_artist, :only => [:new, :create, :edit, :destroy]
  
  def new
    @shop = Shop.find_by_name(params[:shop_id])
    @product = Product.new(:shop => @shop)
  end
  
  def show
    @product = Product.find(params[:id])
    @shop = Shop.find_by_name(params[:shop_id])
  end
  
  def create
    @shop = Shop.find_by_name(params[:shop_id])
    begin
      @product = Product.new(params[:product])
    rescue CarrierWave::IntegrityError
      params[:product][:images] = nil;
      @product = Product.new(params[:product])
      flash[:notice] = "Invalid image file"
      return render :new
    end
    @shop.products << @product
    @shop.save
    redirect_to edit_shop_path(@shop.name)
  end
  
  def edit
    @product = Product.find(params[:id])
    @shop = Shop.find_by_name(params[:shop_id])
  end

  def update
    @product = Product.find(params[:id])
    @shop = Shop.find_by_name(params[:shop_id])
    begin
      @product.write_attributes(params[:product])
    rescue CarrierWave::IntegrityError
      flash[:notice] = "Invalid image file"
      return render :new
    end
    @product.save
    redirect_to edit_shop_path(@shop.name)
  end
  
  def destroy
    @product = Product.find(params[:id])
    @product.delete
    redirect_to edit_shop_path params[:shop_id]
  end
end