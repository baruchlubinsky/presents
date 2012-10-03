class PagesController < ApplicationController
  before_filter :check_login
  before_filter :force_login, :only => 'get_a_present'
  
  def home
    @scroller_images = ScrollerImage.all;
    @tab = 'home'
  end
  def today
    @tab = 'today'
    if params[:page].nil?
      @page = 1
    else
      @page = params[:page].to_i
    end
    @stories = Story.all.where(:online => true).desc(:created_at).skip((@page - 1) * 5).limit(5)
    @total = Story.all.where(:online => true).count
  end
  def posted_presents
    @tab = 'posted'
    @stories = Story.where(:online => true).where(:category => 'Present').desc(:created_at)
    if params[:page].nil?
      @page = 1
    else
      @page = params[:page].to_i
    end
    @stories = Story.all.where(:online => true).where(:category => 'Present').desc(:created_at).skip((@page - 1) * 5).limit(5)
    @total = Story.all.where(:online => true).where(:category => 'Present').count
  end
  def raj_loves
    @tab = 'loves'
    @things = Thing.all.desc(:created_at)
  end
  def get_a_present
    @tab = 'present'
    @products = Product.presents
    @presents = Present.where(:online => true)
  end
  def the_story
    @tab = 'story'
  end
  def shop
    
  end
  def contact
    @tab = 'contact'
  end
end