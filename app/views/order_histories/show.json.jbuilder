json.order_history @order_history, *@order_history.attributes.keys

json.products @product_name_hash do |id, product_name|
    json.id id
    json.name product_name
end

json.single_offer_combos @single_combos do |combo|
	json.organization combo.user.get_organization
	json.combo_history combo, *combo.attributes.keys
	json.combo_product_history combo.combo_product_histories.first, *combo.combo_product_histories.first.attributes.keys
end

json.multiple_offer_combos @multi_combos do |combo|
	json.organization combo.user.get_organization
	json.combo_history combo, *combo.attributes.keys
	json.combo_product_histories combo.combo_product_histories do |product_history|
		json.combo_product_history product_history, *product_history.attributes.keys
		json.product_id product_history.product.id
	end
end

