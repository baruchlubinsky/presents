class PagesController < ApplicationController
  before_filter :check_login
  
  def home
    @scroller_images = ScrollerImage.all;
    @tab = 'home'
  end
  def today
    @tab = 'today'
    @stories = Story.all.where(:online => true).desc(:created_at).limit(5)
  end
  def posted_presents
    @tab = 'posted'
    @stories = Story.where(:category => 'Present').desc(:created_at)
  end
  def raj_loves
    @tab = 'loves'
    @things = Thing.all.desc(:created_at)
  end
  def get_a_present
    @tab = 'present'
    @products = Product.presents
    @presents = Present.where(:available_from.lte => Time.now).where(:available_to.gt => Time.now) 
  end
  def the_story
    @tab = 'story'
  end
  def shop
    
  end
  def contact
    
  end
end