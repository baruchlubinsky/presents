class OrdersController < ApplicationController
  before_filter :force_login  
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
    
    if @order.save
      message = OrderConfirmation.user_create @user, @order
      message.deliver
    end
    
    redirect_to :root
  end
  
  def index
    @orders = Order.includes(:user).includes(:product).all.desc(:created_at).asc(:paid, :shipped)
  end
  
  def show
    @order = Order.find(params[:id])
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
  
end