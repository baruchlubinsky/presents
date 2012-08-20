class CommentNotification < ActionMailer::Base
  default from: "Moderator <raj@presentsinthepost.co.za>"
  
  def new_comment(comment)
    @comment = comment
    mail :to => 'pammijoy@gmail.com', :subject => 'New comment on presents in the post'
  end
  
  
end