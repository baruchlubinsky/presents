class Image
  include Mongoid::Document

  embedded_in :imageable, polymorphic: true
  
  mount_uploader :file, ImageUploader
end