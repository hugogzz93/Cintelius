class ComboHistory < ActiveRecord::Base
	belongs_to :user
    belongs_to :order_history
    has_many :combo_product_histories, dependent: :destroy
    has_many :products, through: :combo_product_histories
    has_one :comment_history, as: :commentable_history, dependent: :destroy

	accepts_nested_attributes_for :combo_product_histories
	accepts_nested_attributes_for :comment_history

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


	# funciones de la version activa
	# def create_review_tickets
	# 	self.combo_product_history.each do |combo_product|
	# 		product_score_id = ProductScore.where(product_id: combo_product.product_id, user_id: self.user_id).first.id
	# 		ReviewTicket.create_ticket_for_product(self.order_id, self.order.user_id, product_score_id, combo_product.product_id)
	# 	end
	# end

	# def self.lock_set(combo_ids)
	# 	return unless combo_ids #checar que no este vacia
	# 	combo_ids.each do |combo_id|
	# 		combo = Combo.find(combo_id)
	# 		combo.update(status: "locked")
	# 	end
	# end
end
