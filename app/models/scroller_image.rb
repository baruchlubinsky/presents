class ScrollerImage
  include Mongoid::Document
  
  field :link, :type => String
  
  embeds_one :image, as: :imageable, :class_name => 'Image', cascade_callbacks: true
  
  validates :image, :presence => {:message => 'Please upload an image'}
  validates :link, :presence => {:link => 'Please set a link'}
  
  default_scope desc(:id)
  
end