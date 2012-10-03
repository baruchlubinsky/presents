class Order
  include Mongoid::Document
  include Mongoid::Timestamps
  field :delivery_address, :type => Hash
  field :paid, :type => Boolean, :default => false
  field :shipped, :type => Boolean
  field :ref_no, :type => String
  field :present, :type => String
  
  embeds_many :order_items, :cascade_callbacks => true
  
  field :options, :type => Hash
  
  belongs_to :user

  def create_ref_no
    self.ref_no ||= Time.now.to_i.to_s << id.to_s.last(2)
  end
  
  def total
    sum = 0;
    self.order_items.each do |p|
      sum = sum + p.price
    end
    return sum
  end
  
end