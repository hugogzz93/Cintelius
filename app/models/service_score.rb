class ServiceScore < ActiveRecord::Base
	belongs_to :user
	has_many :review_tickets, as: :reviewable
	has_one :comment, as: :commentable, dependent: :destroy
	validates :user_id, uniqueness: {message: "Ya existe un registro para este usuario."}
end
