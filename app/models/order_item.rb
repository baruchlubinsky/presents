class OrderItem
  include Mongoid::Document
  
  field :shipped, :type => Boolean
  field :name, :type => String
  field :shop, :type => String
  field :price, :type => Float
  
  embedded_in :order
  
end