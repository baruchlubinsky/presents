class ShopsController < ApplicationController
  before_filter :require_admin, :only => [:new, :create, :destroy, :admin]
  before_filter :require_artist, :only => [:edit, :update]
  
  def index
      @tab = 'shop'
      @shops = Shop.where(:online => true)
      render :layout => 'pages'
  end
  
  def new
    @shop = Shop.new
  end
  
  def create
    @artist = User.where(:email => params[:artist_email]).first
    if @artist.nil?
      redirect_to new_shop_path, :notice => 'That e-mail does not exist on the system. Please make sure that the artist has signed up and try again.'
    else
      @shop = Shop.new(params[:shop])
      @shop.online = false
      @artist[:artist] = true
      @shop.user = @artist
      if @shop.valid?
        @shop.save
        @artist.save
        redirect_to shops_admin_path
      else
        redirect_to new_shop_path, :notice => 'Please ensure that the shop name is unique'        
      end
    end    
  end
  
  def edit
    @shop = Shop.find_by_name(params[:id])
    if (@user[:admin].nil? && @user[:artist] != @shop.name)
      redirect_to '/home'
    end
  end
  
  def update
    @shop = Shop.find_by_name(params[:id])
    @shop.write_attributes(params[:shop])
    @shop.save
    redirect_to shop_path(@shop.name)
  end
  
  def show
    @tab = 'shop'
    @shop = Shop.find_by_name(params[:id])
    render :layout => 'pages'
  end
  
  def admin
    @shops = Shop.all
  end
end