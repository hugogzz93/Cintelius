class Order < ActiveRecord::Base
	belongs_to :user
	has_many :offer_details, dependent: :destroy
	has_many :offers, dependent: :destroy
	has_many :combos, dependent: :destroy
	has_many :order_products, dependent: :destroy
	has_many :products, through: :order_products

	attr_accessor :due_time

	accepts_nested_attributes_for :order_products

	validates :title, presence: true, length: {maximum: 100}

	enum status: [:awaiting_offers, :choosing_offers, :awaiting_products, :closed]
	

end
