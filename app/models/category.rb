class Category < ActiveRecord::Base
	has_many :products
	has_many :subcategories, class_name: "Category", foreign_key: "category_id"
	belongs_to :supercategory, class_name: "Category"

	validates :name, uniqueness: {message: "Ya existe una categoria con este nombre."}
end
