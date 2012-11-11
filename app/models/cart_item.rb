class CartItem
  include Mongoid::Document
  
  field :name, :type => String
  field :shop, :type => String
  field :price, :type => Float
  field :thumbnail, :type => String
  field :note, :type => String
  
  field :options, :type => Hash
  
  embedded_in :cart
  
end