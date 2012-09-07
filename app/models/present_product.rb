class PresentProduct < Product
  field :months, :type => Integer
  has_and_belongs_to_many :orders
  default_scope asc(:months) 
end