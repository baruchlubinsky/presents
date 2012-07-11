class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, :type => String
  field :email, :type => String
  field :website, :type => String
  
  field :content, :type => String
  
  belongs_to :story
  
  default_scope desc(:created_at)
  
  def self.comment_for(user)
    comment = Comment.new
    unless user.nil?
      comment.name = user.name
      comment.email = user.email
    end
    comment
  end
  
  def fix_url
    unless self.website.empty?
      unless self.website.start_with?('http://')
        self.website = 'http://' << self.website
      end
      if self.website.contains('script')
        self.website = ''
      end
    end
  end
  
end
