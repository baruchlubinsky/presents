class Shop
  include Mongoid::Document
  
  field :name, :type => String
  field :description, :type => String
  field :blurb, :type => String
  field :online, :type => Boolean
  
  has_and_belongs_to_many :artists, :class_name => 'User', :inverse_of => nil
  
  has_many :products
  
  embeds_one :cover, as: :imageable, :class_name => 'Image', cascade_callbacks: true 
  embeds_one :logo, as: :imageable, :class_name => 'Image', cascade_callbacks: true
  
  validates :name, :uniqueness => { :message => 'Shop name must be unique'}, :presence => {:message => 'Please enter a shop name'}
  
  def to_param
    name
  end
  
  def self.find_by_name(target)
    self.where(:name => target).first
  end
  
end