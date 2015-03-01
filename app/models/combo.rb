class Combo < ActiveRecord::Base
	belongs_to :user
    belongs_to :order
    has_many :combo_products, dependent: :destroy
    has_many :products, through: :combo_products
    has_one :comment, as: :commentable, dependent: :destroy

	enum status: %w(ready selected locked received)
end
