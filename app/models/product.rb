class Product < ActiveRecord::Base
	  has_and_belongs_to_many :users
 	  has_many :orders, through: :order_products

	  belongs_to :category
	  has_many :offers
	  has_many :combo_products, dependent: :destroy
	  has_many :combos, through: :combo_products, dependent: :destroy
	  has_many :product_scores
end
