class Offer < ActiveRecord::Base
	belongs_to :user
	belongs_to :product
	has_one :comment, as: :commentable
	has_many :offer_details
	has_one :order, through: :offer_details

	enum status: %w(ready pending selected locked received)
end
