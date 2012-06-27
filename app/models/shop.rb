class Shop
  include Mongoid::Document
  
  field :name, :type => String
  field :description, :type => String
  field :online, :type => Boolean
  
  belongs_to :user
  
  has_many :products
  
  validates :name, :uniqueness => true
  
  def to_param
    name
  end
  
  def self.find_by_name(target)
    self.where(:name => target).first
  end
  
end