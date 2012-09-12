class Option
  include Mongoid::Document
  
  field :name, :type => String
  
  mount_uploader :image, ImageUploader
  
  embedded_in :present  
end