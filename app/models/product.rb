class Product < ActiveRecord::Base

	  belongs_to :category
	  has_many :offers
	  has_many :user_products, dependent: :destroy
	  has_many :users, through: :user_products
	  has_many :product_scores
	  has_many :orders, through: :order_products
	  has_many :order_products
	  has_many :combo_products, dependent: :destroy
	  has_many :combos, through: :combo_products, dependent: :destroy

 	  
	  validates :name, uniqueness: {scope: [:category_id], message: "Ya existe un producto con este nombre."}
end
