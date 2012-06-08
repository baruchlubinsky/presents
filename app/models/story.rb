class Story
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :title, :type => String
  field :content, :type => String
  field :category, :type => String
  
  embeds_many :blog_images, as: :imageable, :class_name => 'Image', cascade_callbacks: true

  def summary
    self.content.split("\n")[0]
  end
  
  def images
    self.blog_images.reject {|im| im.file_url.nil?}
  end

end