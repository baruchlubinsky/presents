class Order
  include Mongoid::Document
  
  field :delivery_address, :type => Hash
  field :paid, :type => Boolean, :default => false
  field :shipped, :type => Boolean
  field :ref_no, :type => String
  field :present, :type => String
  
  belongs_to :product
  
  field :options, :type => Hash
  
  belongs_to :user
  
  def create_ref_no
    self.ref_no ||= Time.now.to_i.to_s << id.to_s.last(2)
  end
  
end