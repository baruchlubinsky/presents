require 'digest/sha1'

class User
	include Mongoid::Document
	
	field :first_name, :type => String
	field :surname, :type => String
	
	field :email, :type => String
  field :level, :type => String
	field :salt, :type => String
	index :email, :unique => true
	field :password, :type => String 
	
	field :gender, :type => String
	field :birthdate, :type => Date
	field :hometown, :type => String
	
	field :shoe_size, :type => String
	field :tshirt_size, :type => String

	validates_uniqueness_of :email
	validates_format_of :email, :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, :message => 'Please enter a valid e-mail address'
	validates_presence_of :email, :message => 'Please enter your e-mail address'
	validates_presence_of :password, :message => 'You must provide a password'
	validates_presence_of :first_name, :message => 'Please enter your first name'
	validates_presence_of :last_name, :message => 'Please enter your last name'	
	
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
	
	def name
	  self.first_name + " " + self.surname
	end
	
end
