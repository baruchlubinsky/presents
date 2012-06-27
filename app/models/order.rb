class Order
  include Mongoid::Document
  
  field :delivery_address, :type => Array
  field :paid, :type => Boolean
  field :shipped, :type => Boolean
  field :ref_no, :type => String
  field :present, :type => String
  field :price, :type => String
  
  belongs_to :product
  
  field :options, :type => Hash
  
  belongs_to :user
  
  def create_ref_no
    self.ref_no ||= Time.now.to_i.to_s << id.to_s.last(2)
  end
  
  def price
    if self.present
      
    end
  end
  
end