class ProductsController < ApplicationController
  def new
    @shop = Shop.find_by_name(params[:shop_id])
    if check_artist?
      @product = Product.new(:shop => @shop)
    end
  end
  
  def show
    @tab = 'shop'
    @product = Product.find(params[:id])
    @shop = Shop.find_by_name(params[:shop_id])
    render :layout => 'pages'
  end
  
  def create
    @shop = Shop.find_by_name(params[:shop_id])
    if check_artist?
      begin
        @product = Product.new(params[:product])
        @product.save
      rescue CarrierWave::IntegrityError
        params[:product][:images] = nil;
        @product = Product.new(params[:product])
        flash[:notice] = "Invalid image file"
        return render :new
      end
      @shop.products << @product
      @shop.save
      redirect_to shop_product_path(@shop.name, @product)
    end
  end
  
  def edit
    @product = Product.find(params[:id])
    @shop = Shop.find_by_name(params[:shop_id])
    check_artist?
  end

  def update
    @product = Product.find(params[:id])
    @shop = Shop.find_by_name(params[:shop_id])
    if check_artist?
      begin
        @product.write_attributes(params[:product])
      rescue CarrierWave::IntegrityError
        flash[:notice] = "Invalid image file"
        return render :new
      end
      @product.save
      redirect_to shop_product_path(@shop.name, @product)
    end
  end
  
  def destroy
    @shop = Shop.find_by_name(params[:shop_id])
    if check_artist?
      @product = Product.find(params[:id])
      @product.delete
      redirect_to edit_shop_path params[:shop_id]
    end
  end
end