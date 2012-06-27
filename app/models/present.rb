class Present
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes
  
  field :available_from, :type => Time
  field :available_to, :type => Time
  
  field :recipient, :type => String
  
  embeds_many :options, :class_name => 'Option', cascade_callbacks: true
end