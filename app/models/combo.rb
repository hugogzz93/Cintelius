class Combo < ActiveRecord::Base
	belongs_to :user
    belongs_to :order
    has_many :combo_products, dependent: :destroy
    has_many :products, through: :combo_products
    has_one :comment, as: :commentable, dependent: :destroy

	accepts_nested_attributes_for :combo_products
	accepts_nested_attributes_for :comment

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

end
