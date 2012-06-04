class Item
  include Mongoid::Document
  
  field :name, :type => String
  field :description, :type => String
  field :price, :type => Float
  
  embedded_in :shop
  
end