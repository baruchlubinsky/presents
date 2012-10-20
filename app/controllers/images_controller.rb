class ImagesController < ApplicationController
  def destroy
    @product = Product.find(params[:product_id])
    @shop = Shop.find_by_name(params[:shop_id])
    if check_artist?
      im = @product.images.find(params[:id])
      im.destroy
      @product.save
      redirect_to edit_shop_product_path(@product.shop, @product)
    end
  end
end