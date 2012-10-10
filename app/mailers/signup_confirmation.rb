class SignupConfirmation < ActionMailer::Base
  default from: "Raj <raj@presentsinthepost.co.za>"
  
  def welcome(user, password)
    @user = user.first_name
    @password = password
    mail :to => user.email, :subject => "Welcome to Presents in the Post"
  end
  
end