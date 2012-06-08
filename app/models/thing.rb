class Thing
  include Mongoid::Document
  include Mongoid::Timestamps
  
  embeds_one :image, as: :imageable, cascade_callbacks: true
  
  field :source, :type => String
  
end