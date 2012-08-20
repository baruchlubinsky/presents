class OrderConfirmation < ActionMailer::Base
  default from: "Raj Kulkarani <raj@presentsinthepost.co.za>"
  
  def user_confirm(user, order)
    @recipient = user.name
    @order = order
    mail :to => user.email, :subject => 'Thank you for you order'
  end
  
  def owner_confirm(user, order)
    @customer = user
    @order = order
    mail :to => 'pammijoy@gmail.com', :subject => 'New order received'    
  end
  
  def bank_details(user, order)
    @recipient = user.name
    @order = order
    mail :to => user.email, :subject => 'Presents in the Post Bank Details'
  end
  
end
