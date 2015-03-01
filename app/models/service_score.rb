class ServiceScore < ActiveRecord::Base
	belongs_to :user
	has_many :review_tickets, as: :reviewable
	has_one :comment, as: :commentable, dependent: :destroy
end
