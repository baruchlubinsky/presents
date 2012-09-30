class OrdersController < ApplicationController
  before_filter :force_login, :except => [:success, :cancel] 
  before_filter :require_admin, :only => [:index, :edit, :show, :update]
  
  
  
  def new
    @tab = 'order'
    @order = Order.new
    if params[:product_id]
      @product = Product.find(params[:product_id])
      @products =  Array.new 
      @products << @product
    else
      @present = true
      @products = Product.presents
      @presents = Present.where(:available_from.lte => Time.now).where(:available_to.gt => Time.now)
    end
    render :layout => 'pages'
  end
  
  def create
    @order = Order.new(params[:order])
    if @order.valid?
      @order.order_items.to_a.count.times do |i|
        p = Product.find(@order.order_items[i].product_id)
        @order.order_items[i].write_attributes p.order_item
      end
      @order.create_ref_no
      @order.user = @user
      @order.save
      @payment = my_gate_params
      render :payment
    else
      render :new
    end
  end
  
  def index
    @orders = Order.includes(:user).includes(:product).all.desc(:created_at).asc(:paid, :shipped)
  end
  
  def show
    @order = Order.find(params[:id])
  end
  
  def destroy
    @order = Order.find(params[:id])
    redirect_to :root
  end
  
  def update
    @order = Order.find(params[:id])
    @order.order_items = Array.new
    @order.update_attributes(params[:order])
    if @order.valid?
      @order.order_items.to_a.count.times do |i|
        p = Product.find(@order.order_items[i].product_id)
        @order.order_items[i].write_attributes p.order_item
      end
      @order.create_ref_no
      @order.user = @user
      @order.save
      @payment = my_gate_params
      render :payment
    end
  end
  
  def payment
    @order = Order.find(params[:id])
    @order.update_attributes(params[:order])
    if @order.valid?
      @order.create_ref_no
      @order.user = @user
      @order.save
      @payment = my_gate_params
      render :payment
    end
  end
  
  def edit
    @order = Order.find(params[:id])
    @products = Array.new
    @order.order_items.each do |oi|
      @products << Product.find(oi.product_id)
    end
    if @products[0][:_type] == 'PresentProduct'
      @present = true
      @presents = Present.where(:available_from.lte => Time.now).where(:available_to.gt => Time.now)
    end
    @order.save
    render :layout => 'pages'
  end
  
  def my_gate_params
    payment_params = Hash.new
    if Rails.env == 'development'
      payment_params[:url] = 'https://virtual.mygateglobal.com/PaymentPage.cfm'
      payment_params[:mode] = '0'
      payment_params[:merchant_id] = '50572584-edca-49c3-befe-006897bd1ce4'
      payment_params[:application_id] = '780f4f8c-02a8-4e56-ab44-e29e52f7a09d'
      payment_params[:merchant_reference] = @order.ref_no
      payment_params[:amount] = @order.total
      payment_params[:currency_code] = 'ZAR'
      payment_params[:redirect_successful_url] = success_order_url @order
      payment_params[:redirect_failed_url] = cancel_order_url @order
    elsif Rails.env == 'production'
      payment_params[:url] = 'https://virtual.mygateglobal.com/PaymentPage.cfm'
      payment_params[:mode] = '1'
      payment_params[:merchant_id] = '50572584-edca-49c3-befe-006897bd1ce4'
      payment_params[:application_id] = '780f4f8c-02a8-4e56-ab44-e29e52f7a09d'
      payment_params[:merchant_reference] = @order.ref_no
      payment_params[:amount] = @order.total
      payment_params[:currency_code] = 'ZAR'
      payment_params[:redirect_successful_url] = success_order_url @order
      payment_params[:redirect_failed_url] = cancel_order_url @order
    end
    payment_params
  end
  
  def success
    @order = Order.find(params[:id])
    session[:user_id] = @order.user_id
    @user = User.find session[:user_id]
    @user.cart.cart_items.delete_all
    @user.cart.save
    @order.paid = true
    @order.save
    message = OrderConfirmation.user_confirm @user, @order
    message.deliver
    owner_message = OrderConfirmation.owner_confirm @user, @order
    owner_message.deliver
  end
  
  def cancel
    @order = Order.find(params[:id])
    session[:user_id] = @order.user_id
    @user = User.find session[:user_id]
    @message = params['_ERROR_MESSAGE']
  end
  
  def mail
    @order = Order.find(params[:id])
    message = OrderConfirmation.user_confirm @user, @order
    message.deliver
    owner_message = OrderConfirmation.owner_confirm @user, @order
    owner_message.deliver
  end
  
end