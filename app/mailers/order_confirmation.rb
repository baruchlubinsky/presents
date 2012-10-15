class OrderConfirmation < ActionMailer::Base
  default from: "Raj Pachai <raj@presentsinthepost.co.za>"
  
  def user_confirm(user, order)
    @recipient = user.name
    @order = order
    attachments.inline['signature.jpg'] = File.read("#{Rails.root}/public/images/footer.jpg")
    mail :to => user.email, :subject => "Order Confirmation"
  end
  
  def owner_confirm(user, order)
    @customer = user
    @order = order
    mail :to => 'pammijoy@gmail.com', :subject => "New order received (No. #{@order.ref_no})"   
  end
  
  def bank_details(user, order)
    @recipient = user.name
    @order = order
    attachments.inline['signature.jpg'] = File.read("#{Rails.root}/public/images/footer.jpg")
    mail :to => user.email, :subject => 'Presents in the Post Bank Details'
  end
  
end
