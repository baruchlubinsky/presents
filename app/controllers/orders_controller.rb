class OrdersController < ApplicationController
  before_filter :force_login, :except => [:success, :cancel] 
  before_filter :require_admin, :only => [:index, :edit, :show, :update]
  
  def new
    @order = Order.new
    if params[:product_id]
      @product = Product.find(params[:product_id])
      @order.product = @product
    else
      @present = true
      @products = PresentProduct.all
      @presents = Present.where(:available_from.lte => Time.now).where(:available_to.gt => Time.now)
    end
    render :layout => 'pages'
  end
  
  def create
    @order = Order.new(params[:order])
    @order.create_ref_no
    @order.user = @user
    @order.save
    @payment = my_gate_params
    render :payment
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
    @order.update_attributes(params[:order])
    respond_to do |format|
      format.html do
        @order.save
        redirect_to orders_path
      end
      format.js do
        if @order.save
          render :nothing => true
        else
          render :inline => "alert('Error on save, please reload the page');"
        end
      end
    end
  end
  
  def edit
    @order = Order.find(params[:id])
  end
  
  def my_gate_params
    payment_params = Hash.new
    if Rails.env == 'development'
      payment_params[:mode] = '0'
      payment_params[:merchant_id] = '92aa125b-b814-4b8c-9179-6f10f406ea99'
      payment_params[:application_id] = '665cbd87-fcd6-44ba-82e9-d12ceadef2ff'
      payment_params[:merchant_refernce] = @order.ref_no
      payment_params[:amount] = @order.product.price
      payment_params[:currency_code] = 'ZAR'
      payment_params[:redirect_successful_url] = success_order_url @order, :authenticity_token => session[:_csrf_token]
      payment_params[:redirect_failed_url] = cancel_order_url @order, :authenticity_token => session[:_csrf_token]
    end
    payment_params
  end
  
  def success
    @order = Order.find(params[:id])
    @order.paid = true
    @order.save
    message = OrderConfirmation.user_confirm @user, @order
    message.deliver
    owner_message = OrderConfirmation.owner_confirm @user, @order
    owner_message.deliver
  end
  
  def failure
    @order = Order.find(params[:id])
  end
  
  def mail
    @order = Order.find(params[:id])
    message = OrderConfirmation.user_confirm @user, @order
    message.deliver
    owner_message = OrderConfirmation.owner_confirm @user, @order
    owner_message.deliver
  end
  
end