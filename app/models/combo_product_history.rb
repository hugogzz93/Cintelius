class ComboProductHistory < ActiveRecord::Base
	belongs_to :combo_history
	belongs_to :product

	validates :combo_history_id, uniqueness: { scope: [:product_id],
    message: "No se puede ofrecer el mismo producto dos veces en la misma orden." }

    

	
end
