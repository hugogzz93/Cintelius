class UserDetail < ActiveRecord::Base
	belongs_to :user
	validates :user_id, uniqueness: {message: "Ya existe un registro para este usuario."}

	enum credentials: [:admin, :seller, :buyer]


	def is_buyer?
		self.credentials == "buyer"
	end

	def is_seller?
		self.credentials == "seller"
	end

	def is_admin?
		self.credentials == "admin"
	end
end
