class UserDetail < ActiveRecord::Base
	belongs_to :user
	validates :user_id, uniqueness: {message: "Ya existe un registro para este usuario."}
end
