class ShopsController < ApplicationController
  before_filter :require_admin, :only => [:new, :create, :destroy, :admin]

  def index
      @tab = 'shop'
      @shops = Shop.where(:online => true)
      render :layout => 'pages'
  end
  
  def new
    @shop = Shop.new
  end
  
  def create
      @shop = Shop.new(params[:shop])
      @shop.online = false
      if @shop.valid?
        @shop.save
        @artist.save
        redirect_to shops_admin_path
      else
        redirect_to new_shop_path, :notice => 'Please ensure that the shop name is unique'        
      end   
  end
  
  def edit
    @shop = Shop.find_by_name(params[:id])
    check_artist?
  end
  
  def update
    @shop = Shop.find_by_name(params[:id])
    if check_artist?
      @shop.write_attributes(params[:shop])
      @shop.save
      if @shop.online
        redirect_to shop_path(@shop.name)
      else
        redirect_to preview_shop_path(@shop.name)
      end
    end
  end
  
  def show
    @tab = 'shop'
    @shop = Shop.find_by_name(params[:id])
    render :layout => 'pages'
  end
  
  def preview
    @tab = 'shop'
    @shop = Shop.find_by_name(params[:id])
    if check_artist?
      render :layout => 'pages'
    end
  end
  
  def admin
    @shops = Shop.all
  end
  
  def add_artist
    @shop = Shop.find_by_name(params[:id])
    if check_artist?
      artist = User.where(:email => params[:artist_email]).first
      unless artist.nil?
        @shop.artists << artist
        @shop.save
        redirect_to edit_shop_path(@shop.name)
      else
        redirect_to edit_shop_path(@shop.name), :notice => 'E-mail address not found. Please ensure that the artist has signed up.'
      end
    end
  end
  
  def remove_artist
    @shop = Shop.find_by_name(params[:id])
    if check_artist?
      remove = User.find(params[:artist_id])
      @shop.artists.delete(remove)
      @shop.save
      redirect_to edit_shop_path(@shop.name)
    end
  end
  
end