class Combo < ActiveRecord::Base
	belongs_to :user
    belongs_to :order
    has_many :combo_products, dependent: :destroy
    has_many :products, through: :combo_products
    has_one :comment, as: :commentable, dependent: :destroy

	accepts_nested_attributes_for :combo_products
	accepts_nested_attributes_for :comment

	# after_update :create_review_tickets, if: :received?

    validates :price, presence: true, numericality: true

	enum status: [:ready, :selected, :locked, :received]

	def is_ready?
		self.status == "ready"
	end

	def is_selected?
		self.status == "selected"
	end

	def is_locked?
		self.status == "locked"
	end

	def is_received?
		self.status == "received"
	end

	def organization
		self.user.user_detail.organization
	end

	# def create_review_tickets
	# 	self.combo_products.each do |combo_product|
	# 		product_score_id = ProductScore.where(product_id: combo_product.product_id, user_id: self.user_id).first.id
	# 		ReviewTicket.create_ticket_for_product(self.order_id, self.order.user_id, product_score_id, combo_product.product_id)
	# 	end
		
	# end

	def self.lock_set(combo_ids)
		return unless combo_ids #checar que no este vacia
		combo_ids.each do |combo_id|
			combo = Combo.find(combo_id)
			combo.update(status: "locked")
		end
	end

	def create_history_recursively(order_history_object)
		history_object_hash = self.attributes
		history_object_hash.delete("id")
		history_object_hash.delete("order_id")
		history_object_hash["order_history_id"] = order_history_object.id
		combo_history_object = ComboHistory.create(history_object_hash)
		self.combo_products.each do |combo_product|
			combo_product.create_history_recursively(combo_history_object)
		end
		self.comment.create_history_recursively(combo_history_object)
	end
end
