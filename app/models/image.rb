class Image
  include Mongoid::Document

  embedded_in :imageable, polymorphic: true
  
  mount_uploader :file, ImageUploader
  
  field :source, :type => String
  
  field :source_label, :type => String
end