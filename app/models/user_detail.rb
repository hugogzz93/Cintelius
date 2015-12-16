class UserDetail < ActiveRecord::Base
	belongs_to :user
	validates :user_id, uniqueness: {message: "Ya existe un registro para este usuario."}

	enum credentials: [:admin, :seller, :buyer]
	# enum state: [:nuevo_leon]
	# enum city: [[:Apodaca :Escobedo :Guadalupe :San Nicolás de los Garza :San Pedro Garza García "Santa Catarina"];]


	def is_buyer?
		self.credentials == "buyer"
	end

	def is_seller?
		self.credentials == "seller"
	end

	def is_admin?
		self.credentials == "admin"
	end

	def make_admin
		self.update(credentials: "admin")
	end
end
