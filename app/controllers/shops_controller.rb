class ShopsController < ApplicationController
  before_filter :require_admin, :only => [:new, :create, :destroy]
  before_filter :require_artist, :only => [:edit]
  
  def index
    if @user.nil? || @user[:admin].nil?
      @shops = Shop.where(:online => true)
      render :layout => 'pages'
    else
      @shops = Shop.all
    end
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
        redirect_to shops_path
      else
        redirect_to new_shop_path, :notice => 'Please ensure that the shop name is unique'        
      end
    end    
  end
  
  def edit
    @shop = Shop.find_by_name(params[:id])
    unless @shop.user_id == @user.id
      redirect_to '/login', :notice => 'Only the artist may enter this page'
    end
  end
  
  def update
    @shop = Shop.find_by_name(params[:id])
    @shop.write_attributes(params[:shop])
    @shop.save
    redirect_to shops_url << "/#{@shop.name}"
  end
  
  def show
    @shop = Shop.find_by_name(params[:id])
    render :layout => 'pages'
  end
  
  
  
end