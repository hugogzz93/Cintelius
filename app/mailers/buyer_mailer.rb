class BuyerMailer < ActionMailer::Base
  default from: "no-reply@cintelius.com"

  def order_visible(order)
  	@order = order
  	# mail to: current_user.email, subject: "Cotizacion lista"	
  end

end
