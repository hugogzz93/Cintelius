class Order < ActiveRecord::Base
	belongs_to :User
	has_many :offer_details, dependent: :destroy
	has_many :offers, dependent: :destroy
	has_many :combos, dependent: :destroy
	has_many :order_products, dependent: :destroy
	has_many :products, through: :order_products

	accepts_nested_attributes_for :order_products

	validates :title, presence: true, length: {maximum: 100}
	

end
