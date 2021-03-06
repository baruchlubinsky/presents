class Story
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :title, :type => String
  field :content, :type => String
  field :intro, :type => String
  field :category, :type => String
  field :online, :type => Boolean, :default => false
  
  has_many :comments
  
  embeds_many :blog_images, as: :imageable, :class_name => 'Image', cascade_callbacks: true
  
  validates :title, :presence => {:message => 'Story must have a title'}

  def summary
    self.content.split("\n")[0]
  end
  
  def images
    self.blog_images.reject {|im| im.file_url.nil?}
  end

end