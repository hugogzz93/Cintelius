class OrderHistory < ActiveRecord::Base
	belongs_to :user
	has_many :review_tickets, dependent: :destroy
	has_many :offer_detail_histories, dependent: :destroy
	has_many :offer_histories, dependent: :destroy
	has_many :combo_histories, dependent: :destroy
	has_many :order_product_histories, dependent: :destroy
	has_many :products, through: :order_products
	has_one :comment_history, as: :commentable_history, dependent: :destroy

	attr_accessor :due_time

	accepts_nested_attributes_for :order_product_histories
	accepts_nested_attributes_for :comment_history

	# after_create :create_review_tickets

	validates :title, presence: true, length: {maximum: 100}




	# open: usuario puede seleccionar ofertas, locked: ya selecciono, closed: se recibieron los productos

	enum status: [:open, :locked, :closed]

	def total_cost
		total = 0
		self.combo_histories.each do |combo_history|
			total += combo_history.price
		end
		return total.to_f
	end

	def due_date_past?
		self.due_date <= Time.zone.now
	end

	def is_locked?
		self.status == "locked"
	end

	def is_open?
		self.status == "open"
	end

	def is_closed?
		self.status == "closed"
	end


	# divide en combos con uno o muchos productos
	def get_combos_divided_by_quantity
		single_product = Array.new
		multi_product = Array.new

		combo_histories = self.combo_histories.includes(:combo_product_histories, :comment_history)

		self.combo_histories.each do |combo_history|
			if combo_history.combo_product_histories.size > 1
				multi_product << combo_history 
			else
				single_product << combo_history 
			end
		end
		return single_product, multi_product
	end

	# regresa un hash ligando los nombres de productos con sus ids
	def get_product_name_hash
		product_id_name_hash = Hash.new
		self.order_product_histories.each do |order_product_history| 
			product_id = order_product_history.product.id
			product_name = order_product_history.product.name
			product_id_name_hash[product_id] = product_name
		end
		return product_id_name_hash
	end

	# clasifica todas las ofertas de productos individuales por producto
	# y toda las ofertas de varios productos por proveedor
	def table_format
		single_product_hash = Hash.new { |h, k| h[k] = [] } # la llave es el producto y el valor es una lista de ofertas
		multi_product_hash = Hash.new { |q, w| q[w] = Hash.new { |e, r| e[r] = Hash.new  } }

		single_product, multi_product = self.get_combos_divided_by_quantity
		single_product.each do |single_combo| 
			product_id = single_combo.combo_product_histories.first.product_id
			single_product_hash[product_id] << single_combo
		end

		# provider > combo id > product id
		multi_product.each do |multi_combo|
			provider_id = multi_combo.user_id
			multi_combo.combo_product_histories.each do |combo_product|
				multi_product_hash[provider_id][multi_combo.id][combo_product.product_id] = combo_product
			end
		end

		return single_product_hash, multi_product_hash
	end


	# regresa un hash donde se clasifican los historiales de ordenes por mes (order history controller)
	def self.get_order_histories_hash(year, user_id)
		order_histories = Hash.new()
		for i in 1..Time.zone.now.month
			# busca ordenes creadas en el mes # i
			earliest = Time.new(Time.zone.now.year, i) 
			latest = earliest.end_of_month 

			order_histories[i] = OrderHistory.where(user_id: user_id, created_at: (earliest..latest))
		end
		return order_histories
	end

	# regresa un hash donde cada proveedor tiene un arreglo de ofertas
	def sort_offer_histories_by_provider
		provider_hash = Hash.new()
		provider_list = self.offer_histories.collect {|offer| offer.organization}.uniq
		provider_list.each do |prov|
			provider_hash[prov] = Array.new
		end
		
		self.offer_histories.each do |offer_history|
			provider_hash[offer_history.organization] << offer_history
		end
		return provider_hash
	end

	def sort_combo_histories_by_provider
		provider_hash = Hash.new()
		provider_list = self.combo_histories.collect {|combo| combo.organization}.uniq
		provider_list.each do |prov|
			provider_hash[prov] = Array.new
		end
		
		self.combo_histories.each do |combo_history|
			provider_hash[combo_history.organization] << combo_history
		end
		return provider_hash
	end

	# proveedores que tienen alguna oferta o combo
	def get_participating_providers
		provider_list = Array.new
		self.offer_histories.each do |offer|
			provider_list << offer.user.get_organization
		end

		self.combo_histories.each do |combo|
			provider_list << combo.user.get_organization
		end

		return provider_list.uniq
	end

	# # proveedores que tienen un producto seleccionado
	def get_received_product_providers
		providers_from_offer_histories = self.offer_histories.where(status: OfferHistory.statuses[:received]).collect {|offer_history| offer_history.user}.uniq
		providers_from_combo_histories = self.combo_histories.where(status: ComboHistory.statuses[:received]).collect {|combo_history| combo_history.user}.uniq
		providers = providers_from_combo_histories + providers_from_offer_histories
		return providers.uniq

	end

	def create_review_tickets
		providers = self.get_received_product_providers
		providers.each do |provider| 
			self.review_tickets.create(reviewable_type: "ServiceScore", user_id: self.user_id, reviewable_id: provider.service_score.id)
		end
		self.combo_histories.where(status: ComboHistory.statuses[:received]).each do |combo_history|
			combo_history.combo_product_histories.each do |combo_product_history|
				product_score_id = ProductScore.where(product_id: combo_product_history.product_id, user_id: combo_history.user_id).first.id
				ReviewTicket.create_ticket_for_product(self.id, self.user_id, product_score_id, combo_product_history.product_id)
			end
		end
		# no agrege para ofertas porque todavia no decidimos si las vamos a dejar o no
	end

	def get_service_review_tickets
		review_tickets = self.review_tickets.where(reviewable_type: "ServiceScore")
	end

	def get_product_review_tickets
		review_tickets = self.review_tickets.where(reviewable_type: "ProductScore")
	end



	# def self.lock(order_id, offer_ids, combo_ids)
	# 	Offer.lock_set(offer_ids)
	# 	Combo.lock_set(combo_ids)
	# 	order = Order.find(order_id)
	# 	order.update(status: "locked")
	# 	return 0
	# end

	# def close
	# 	# pasar al historial
	# end

	# def create_service_review_tickets
	# 	providers = self.get_selected_providers
	# 	providers.each do |provider| 
	# 		self.review_tickets.create(reviewable_type: "ServiceScore", user_id: self.user_id, reviewable_id: provider.service_score.id)
	# 	end
	# end


	

	# def get_service_review_tickets
	# 	review_tickets = self.review_tickets.where(reviewable_type: "ServiceScore")
	# end

	# def get_product_review_tickets
	# 	review_tickets = self.review_tickets.where(reviewable_type: "ProductScore")
	# end

	# def reset

	# 	self.update(status: 0)
		
	# 	self.offers.each do |offer|
	# 		offer.offer_details.each do |a|
	# 			a.update(status: 0)
	# 		end
	# 		offer.update(status: 0)
	# 	end

	# 	self.combos.each do |combo|
	# 		combo.update(status: 0)
	# 	end

	# 	self.review_tickets.destroy
	# end



end
