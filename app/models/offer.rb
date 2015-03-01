class Offer < ActiveRecord::Base
	belongs_to :user
	belongs_to :product
	has_one :comment, as: :commentable, dependent: :destroy
	has_many :offer_details, dependent: :destroy
	has_one :order, through: :offer_details

	validates :unitary_price, presence: true, numericality: true

	enum status: %w(ready pending selected locked received)
end
