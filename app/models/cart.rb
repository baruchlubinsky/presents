class Cart
  include Mongoid::Document
  
  embedded_in :user
  
  embeds_many :cart_items
  
end