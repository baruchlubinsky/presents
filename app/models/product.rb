class Product
  include Mongoid::Document
  
  field :name, :type => String
  field :description, :type => String
  field :price, :type => Float
  field :online, :type => Boolean
  field :months, :type => Integer
  
  embeds_many :images, as: :imageable, :class_name => 'Image', cascade_callbacks: true 
  
  scope :presents, where(:_type => 'PresentProduct').asc(:months)
  
  belongs_to :shop
  
  validates_presence_of :name, :message => "Please provide a name for this product"
  validates_presence_of :price, :message => "Product must have a price"
    
  def order_item
    {price: price, name: name, shop: (shop ? shop.name : "Presents in the Post" )}
  end  
    
end