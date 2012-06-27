require 'digest/sha1'

class User
	include Mongoid::Document
	
	field :name, :type => String
	field :email, :type => String
  field :level, :type => String
	field :salt, :type => String
	index :email, :unique => true
	field :password, :type => String 

	validates_uniqueness_of :email
	validates_format_of :email, :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	
	has_many :orders
	
	has_one :shop
	
  def hash_password(pw)
    self.salt ||= Digest::SHA1.hexdigest(Time.now.to_s)
    Digest::SHA2.hexdigest(pw + self.salt)
  end
    
	def password=(val)
	  self.write_attribute(:password, self.hash_password(val))
	end
	
	def password_match?(pw)
	  self.hash_password(pw) == self.password
	end
	
end
