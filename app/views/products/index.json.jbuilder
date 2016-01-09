json.products @products do |product|
    json.id product.id
    json.name product.name
    json.subcategory  do 
    	json.name product.category.name
    	json.id product.category.id
    end
end