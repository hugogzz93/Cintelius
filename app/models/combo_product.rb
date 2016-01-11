class ComboProduct < ActiveRecord::Base
	belongs_to :combo
	belongs_to :product


	# before_destroy :create_history
	validates :combo_id, uniqueness: { scope: [:product_id],
    message: "No se puede ofrecer el mismo producto dos veces en la misma orden." }

	validates :unitary_price, presence: true, 
    				numericality: { greater_than: 0 }

    def create_history_recursively(combo_history_object)
		history_object_hash = self.attributes
		history_object_hash.delete("id")
		history_object_hash.delete("combo_id")
		history_object_hash["combo_history_id"] = combo_history_object.id
		ComboProductHistory.create(history_object_hash)
	end

	
end
