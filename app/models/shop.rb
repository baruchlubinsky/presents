class Shop
  include Mongoid::Document
  
  field :name, :type => String
  
  belongs_to :user
  
  embeds_many :items
  
end