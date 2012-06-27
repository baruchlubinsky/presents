class Option
  include Mongoid::Document
  
  field :name, :type => String
  
  mount_uploader :image, OptionImageUploader
  
  embedded_in :present  
end