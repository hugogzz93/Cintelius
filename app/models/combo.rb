class Combo < ActiveRecord::Base
	belongs_to :user
    belongs_to :order
    has_many :products, through: :combo_products
    has_one :comment, as :commentable

	enum status: %w(ready selected locked received)
end
