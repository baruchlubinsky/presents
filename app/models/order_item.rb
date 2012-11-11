class OrderItem
  include Mongoid::Document
  
  field :shipped, :type => Boolean
  field :name, :type => String
  field :shop, :type => String
  field :price, :type => Float
  field :note, :type => String
  
  field :options, :type => Hash
  
  embedded_in :order
  
end