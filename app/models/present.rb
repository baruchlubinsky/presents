class Present
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes
  
  field :online, :type => Boolean
  
  field :recipient, :type => String
  field :orders, :type => Integer
  
  embeds_many :options, :class_name => 'Option', cascade_callbacks: true
end