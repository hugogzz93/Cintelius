class ComboProduct < ActiveRecord::Base
	belongs_to :combo
	belongs_to :product
end
