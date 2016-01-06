class ProviderMailer < ActionMailer::Base
  default from: "no-reply@cintelius.com"

  def order_received(organization, dueDate, recipients)
  	@organization = organization
  	@dueDate = dueDate
  	@recipients = recipients
  	# mail to: @recipients, subject: "Nueva Orden Cintelius"
  end

end
