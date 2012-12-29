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
    @order.order_items.to_a.count.times do |i|
      p = Product.find(@order.order_items[i].product_id)
      @order.order_items[i].write_attributes p.order_item
      if @order.order_items[i].options['delivery_note']
        @order.options['delivery_note'] = @order.order_items[i].options['delivery_note']
      end
    end
    @order.create_ref_no
    @order.user = @user
    @order.save
    @payment = my_gate_params
    render 'orders/payment'
  end
  
  def index
    if params[:from]
      @from_date = DateTime.new(params[:from]['date(1i)'].to_i, params[:from]['date(2i)'].to_i, params[:from]['date(3i)'].to_i).to_time
    else
      present = Present.where(:online => true).asc(:created_at).first
      if present.nil?
        present = Present.where(:online => false).desc(:created_at).first
        @from_date = present.created_at
      else
        @from_date = present.created_at
      end
    end
    if params[:to]
      @to_date = DateTime.new(params[:to]['date(1i)'].to_i, params[:to]['date(2i)'].to_i, params[:to]['date(3i)'].to_i).to_time
    else
      @to_date = DateTime.now
    end
    @orders = Order.includes(:user).where(:created_at.gt => @from_date).where(:created_at.lt => @to_date).asc(:paid, :shipped).desc(:created_at)
  end
  
  def show
    @order = Order.find(params[:id])
  end
  
  def search
    @order = Order.where(:ref_no => params[:ref_no]).first
    redirect_to edit_order_path @order
  end
  
  def destroy
    @order = Order.find(params[:id])
    @order.delete
    redirect_to :root
  end
  
  def update
    @order = Order.find(params[:id])
    @order.order_items = Array.new
    @order.update_attributes(params[:order])
    @order.save
    redirect_to :index
  end
  
  def payment
    if Order.exists?(:conditions => {:id => params[:id]})
      @order = Order.find(params[:id])
      @order.order_items = Array.new
      @order.write_attributes(params[:order])
    else
      @order = Order.new(params[:order])
    end
    if params[:order][:delivery_address].nil?
      @has_add = true
      @order.delivery_address = Hash.new
    else
      if params[:order][:delivery_address]['0'].empty? || params[:order][:delivery_address]['post_code'].empty?
        @has_add = false
      else
        @has_add = true
      end
    end
    if @has_add
      @order.create_ref_no
      @order.user = @user
      @order.save
      if params[:commit] == "Pay by credit card"
        @payment = my_gate_params
        render :payment
      else
        redirect_to mail_order_path(@order)
      end
    else
      @order[:error] = 'Please enter an address and a post code.'
      if @order.options.nil?
        @order.options = Hash.new
      end
      redirect_to checkout_path
    end
  end
  
  def edit
    @order = Order.find(params[:id])
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
      payment_params[:recipient] = @order.user.name
      payment_params[:shipping_address1] = @order.delivery_address["0"]
      payment_params[:shipping_address2] = (@order.delivery_address["1"] || ' ')
      payment_params[:shipping_address3] = (@order.delivery_address["2"] || ' ')
      payment_params[:shipping_address4] = @order.delivery_address["post_code"]
      
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
      payment_params[:recipient] = @order.user.name      
      payment_params[:shipping_address1] = @order.delivery_address["0"]
      payment_params[:shipping_address2] = (@order.delivery_address["1"] || ' ')
      payment_params[:shipping_address3] = (@order.delivery_address["2"] || ' ')
      payment_params[:shipping_address4] = @order.delivery_address["post_code"]
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
    render :layout => 'pages'
  end
  
  def cancel
    @order = Order.find(params[:id])
    session[:user_id] = @order.user_id
    @user = User.find session[:user_id]
    @message = params['_ERROR_MESSAGE']
  end
  
  def mail
    @order = Order.find(params[:id])
    @order.options ||= Hash.new
    @order.options[:eft] = 'EFT'
    @order.save
    message = OrderConfirmation.bank_details @user, @order
    message.deliver
    owner_message = OrderConfirmation.owner_confirm_eft @user, @order
    owner_message.deliver
    @user = User.find session[:user_id]
    @user.cart.cart_items.delete_all
    @user.cart.save
    render :layout => 'pages'
  end
  
end