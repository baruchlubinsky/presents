class PagesController < ApplicationController
  before_filter :check_login
  
  def home
    
#    @news = Story.where(:category => 'News').desc(:created_at).first
#    @present = Story.where(:category => 'Present').desc(:created_at).first
#    @things = Thing.all.desc(:created_at).limit(6)
#    @shops = Shop.where(:online => true).includes(:products)
#    @all_products = []
#    @shops.each do |shop|
#      shop.products.each {|p| @all_products.push p}
#    end
#    @all_products.sort_by! { |p| p.id.to_s }
#    @all_products.reverse!
#    @products = @all_products.take(3)
    
    @scroller_images = ScrollerImage.all;
  end
  def today
    @stories = Story.all.desc(:created_at).limit(5)
  end
  def posted_presents
    @stories = Story.where(:category => 'Present').desc(:created_at)
  end
  def raj_loves
    @things = Thing.all.desc(:created_at)
    
  end
  def about
    
  end
  def the_story
  
  end
  def shop
    
  end
end