class OrderHistory < ActiveRecord::Base
	belongs_to :user
	has_many :offer_detail_histories, dependent: :destroy
	has_many :offer_histories, dependent: :destroy
	has_many :combo_histories, dependent: :destroy
	has_many :order_product_histories, dependent: :destroy
	has_many :products, through: :order_products
	has_one :comment_history, as: :commentable_history, dependent: :destroy

	attr_accessor :due_time

	accepts_nested_attributes_for :order_product_histories
	accepts_nested_attributes_for :comment_history

	# after_update :create_service_review_tickets, if: :locked?

	validates :title, presence: true, length: {maximum: 100}


	# open: usuario puede seleccionar ofertas, locked: ya selecciono, closed: se recibieron los productos

	enum status: [:open, :locked, :closed]

	def due_date_past?
		# if due_date <= Time.now
		# 	self.update(status: "choosing_offers")
		# 	return true
		# else
		# 	return false
		# end

		self.due_date <= Time.now
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


	# # proveedores que tienen un producto seleccionado
	# def get_selected_providers
	# 	providers_from_offers = self.offers.where(status: Offer.statuses[:locked]).collect {|offer| offer.user}.uniq
	# 	providers_from_combos = self.combos.where(status: Combo.statuses[:locked]).collect {|combo| combo.user}.uniq
	# 	providers = providers_from_combos + providers_from_offers
	# 	return providers.uniq

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
