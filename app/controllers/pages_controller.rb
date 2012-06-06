class PagesController < ApplicationController
  before_filter :check_login
  
  def home
    
  end
  def news
    @stories = Story.all.desc(:created_at).limit(5)
  end
  def past_presents
    
  end
  def things_i_like
    @things = Thing.all.desc(:created_at)
    
  end
  def about
    
  end
  def shop
    
  end
end