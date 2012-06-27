class OrdersController < ApplicationController
  before_filter :force_login  
  
  def new
    @order = Order.new
    if params[:product_id]
      @product = Product.find(params[:product_id])
    else
      @presents = Present.where(:available_from.lte => Time.now).where(:available_to.gt => Time.now)
    end
  end
  
  def create
    @order = Order.new(@params[:order])
    @order.create_ref_no
    
  end

  
end