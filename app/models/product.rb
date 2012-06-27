class Product
  include Mongoid::Document
  
  field :name, :type => String
  field :description, :type => String
  field :price, :type => Float
  field :online, :type => Boolean
  
  has_many :orders
  
  embeds_many :images, as: :imageable, :class_name => 'Image', cascade_callbacks: true 
  
  belongs_to :shop
    
end