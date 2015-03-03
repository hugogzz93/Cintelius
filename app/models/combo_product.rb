class ComboProduct < ActiveRecord::Base
	belongs_to :combo
	belongs_to :product

	validates :combo_id, uniqueness: { scope: [:product_id],
    message: "No se puede ofrecer el mismo producto dos veces en la misma orden." }

	
end
