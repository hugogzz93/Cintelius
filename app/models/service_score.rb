class ServiceScore < ActiveRecord::Base
	belongs_to :user
	has_many :review_tickets, as :reviewable
end
