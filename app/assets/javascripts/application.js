// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


$(function() {



	// @@NEWORDER

	// Arreglar tamaño de la pantalla.
	$('body').height($(window).height());

	// Para que la subcategoria tenga el efecto fade-in
	$('ul.category-list button').on('click', function(e) {
		e.preventDefault();
		className = "." + e.target.textContent + "-list";
		// indexNo = $('.category-list button:contains(\"' + e.target.textContent +'")').parent().index();

		$('.subcategories ul, .category-list button').removeClass('active');
		$('.products ul').removeClass('active');
		$(className).addClass('active');
		// $($(className).children()[indexNo]).css('border-left', 'none')

		$(e.target).addClass('active');		
	})

	$('.subcategories ul li button').on('click', function(e) {
		e.preventDefault();
		className = "." + e.target.textContent + "-list";
		// indexNo = $('.subcategory-list button:contains(\"' + e.target.textContent +'")').parent().index();

		$('.subcategories ul li button').removeClass('active');
		$('.products ul').removeClass('active');

		$(className).addClass('active');
		// $($(className).children()[indexNo]).css('border-left', 'none')

		$(e.target).addClass('active');	
	})


	// Click agrega el nombre al product_box o destruye la caja si ya esta seleccionado el prod
	$('.products button').on('click', function(e) {
		if ($(e.target).hasClass('selected_product')) {
			$('.product_box:contains('+ $(e.target).text() +')').remove();
			$(e.target).removeClass('selected_product')
		} else {
			$('a.add_fields').click()
			productName = $(e.target).text()
			product_fields = $('.product_box').last().children().first()
			product_fields.text(productName)
			$($('.product_box').last().children().get(2)).val($(e.target).attr('data-product-id'))
			orderProductId = $($('.newOrder .product_box').last().children('textarea').siblings().get(2)).attr('name').slice(33, 46)
			commentName = "order[order_products_attributes][" + orderProductId + "][comment_attributes][content]"
			// $($('.product_box').last().children('textarea').siblings().get(2)).attr('id')
			console.log(commentName)
			$($('.product_box').last().children('textarea')).attr('name', commentName)
			$(e.target).addClass('selected_product')
		}

	})

	// Agrega caja de producto

	$('form .add_fields').on('click', function(e) {
		time = new Date().getTime()
		regexp = new RegExp($(this).data('id'), 'g')
		$(this).before($(this).data('fields').replace(regexp, time))
		event.preventDefault()
	})

	// $('.product_box').last().children().first().text('Carne')

	// Para que cada producto agrege un nuevo campo
	// function add_fields(link, association, content) {
	// 	var new_id = new Date.getTime();
	// 	var regexp = new RegExp("new_" + association, "g")
	// 	$(link).up().insert({
	// 		before: content.replace(regexp, new_id)
	// 	});
	// }

	// $$NEWORDER
})
