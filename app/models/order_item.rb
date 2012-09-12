class OrderItem
  include Mongoid::Document
  
  field :shipped, :type => Boolean
  field :name, :type => String
  field :shop, :type => String
  field :price, :type => Float
  field :note, :type => String
  
  embedded_in :order
  
end