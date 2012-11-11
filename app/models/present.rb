class Present
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes
  include Mongoid::Timestamps
  
  field :online, :type => Boolean
  
  field :delivery_note, :type => String
  
  field :recipient, :type => String
  field :orders, :type => Integer
  
  embeds_many :options, :class_name => 'Option', cascade_callbacks: true
end