class ScrollerImage
  include Mongoid::Document
  
  field :link, :type => String
  
  embeds_one :image, as: :imageable, :class_name => 'Image', cascade_callbacks: true
  
end