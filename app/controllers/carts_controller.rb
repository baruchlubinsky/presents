class CartsController < ApplicationController
  before_filter :force_login
  layout 'pages'
  
  def show
    @items = @user.cart.cart_items
  end

  def add_item
    product = Product.find(params[:product_id])
    @user.cart ||= Cart.new
    cart_item = CartItem.new({:name => product.name,
                              :price => product.price,
                              :shop => product.shop.name,
                              :thumbnail => product.images.first.file_url(:thumbnail)})
    @user.cart.cart_items << cart_item
    @user.cart.save
    redirect_to '/cart/show'
  end
  
  def add_present
    product = Product.find(params[:product_id])
    present = Present.find(params[:options][:recipient])
    present.orders ||= 0
    present.orders += 1 
    present.save
    cart_item = CartItem.new({:name => "#{product.description} for a #{present.recipient}",
                              :price => product.price, 
                              :shop => 'Presents in the Post', 
                              :thumbnail => present.options[params[:options][:choice].to_i].image_url, 
                              :note => present.options[params[:options][:choice].to_i].name })
                              
    @user.cart ||= Cart.new
    @user.cart.cart_items << cart_item
    @user.cart.save
    redirect_to '/cart/show'
  end
  
  def remove_item
    @user.cart.cart_items.find(params[:id]).delete
    redirect_to '/cart/show'
  end
  
  def checkout
    if params[:order_id]
      @order = Order.find params[:order_id] 
      if @order.options.nil?
        @order.options = Hash.new
      end
    else
      @order = Order.new
      @order.options = Hash.new
      @order.delivery_address = Hash.new
      @order.order_items = Array.new
      @user.cart.cart_items.each do |cart|
        @order.order_items << OrderItem.new({:name => cart.name, 
                                           :price => cart.price, 
                                           :shop => cart.shop, 
                                           :note => cart.note, 
                                           :shipped => false})
      end
    end
end

end