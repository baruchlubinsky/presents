class OrderConfirmation < ActionMailer::Base
  default from: "Raj <orders@presentsinthepost.co.za>"
  
  def user_create(user, order)
    @recipient = user.name
    @order = order
    mail :to => user.email, :subject => 'Thank you for you order'
  end
    
  
end
