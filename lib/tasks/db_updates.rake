task :check_order_due_date => :environment do
	orders = Order.where(status: "awaiting_offers")
	orders.each do |order|
		if order.due_date_past? 
			puts "Updated #{order.id}: #{order.title}"
		end
	end	
	puts "Order due_Date update: #{I18n.l Time.zone.now, format: :cust}"
end