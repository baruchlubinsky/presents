class ImagesController < ApplicationController
  before_filter :require_artist
  def destroy
    @product = Product.find(params[:product_id])
    im = @product.images.find(params[:id])
    im.destroy
    @product.save
    redirect_to edit_shop_product_path(@product.shop, @product)
  end
end