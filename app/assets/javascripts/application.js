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
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery-ui/datepicker
//= require turbolinks
//= require_tree .


// var do_on_load = function() { 
$(function() {

	// $('.top-bar a').on('click', function(e) {
	// 	$('choice').removeClass('choice')
	// 	$(e.target).addClass('choice')
	// 	console.log('added choice')
	// })

	$('.top-bar a').on('click', function(e) {
		$('.top-bar .loader').removeClass('hidden')
		console.log('loader revealed')
	})

	// selecciona el producto desde una orden reciente
	$('.order_product_history').on('click', function(e) {
		productId = $(e.target).attr('data-order-product-id')
		units = $(e.target).attr('data-order-product-units')
		$('.order_product_history[data-order-product-id=' + productId + ']').toggleClass('active')
		$('button[data-product-id=' + productId + ']').click();	
		$('.product_box[data-product-id=' + productId + '] input[type=number]').val(units)
	})

	$('.recent_order_title').on('click', function(e) {
		$(e.target).siblings('.recent_order_products').toggleClass('inactive')
	})

	$('.recent_orders_widget_header').on('click', function(e) {
		$('.recent_orders_widget').toggleClass('inactive')

	})



	$('#new_order_form_continue_button').on('click', function(e) {
		e.preventDefault();
		for (var i = 0; i < $('.new_order_unit_field input').size(); i++) {
			if ($($('.new_order_unit_field input')[i]).val() == '') {
				alert('Debes de establecer la cantidad de kilos')
				return false
			};
		};
		$('.new_order_pop_up_screen').addClass('active')
		$('.product_form_area').addClass('active')
		$('#new_order_form_continue_button').css('display', 'none')
	})

	$('#new_order_submit').on('click', function(e) {
		$(e.target).css('display', 'none');
		$(e.target).off('click');
		$('#new_order').submit()
	})

	$('.new_order_pop_up_screen').on('click', function(e) {
		$('.new_order_pop_up_screen').removeClass('active')
		$('.product_form_area').removeClass('active')
		$('#new_order_form_continue_button').css('display', 'block')
	}).children().on('click', function() {
		return false;
	})

	$('.user_settings_list a').on('click', function() {
		$('.content_body').empty()
		$('.loading_animation_screen').addClass('active')
		$('.loading_animation').addClass('active')
	})


	// Order Index {

	

	$('.order_box a').on('click', function(e) {
	
		// limpia la lista de ofertas y objetivos
		$('.offer_list').empty()
		$('.order_product_list').empty()
	
		// agregar animacion de cargando
		$('.loading_animation').addClass('active');
	
	
		$('.order_box').removeClass('fade-in').addClass('fade-out');
		$($(e.target).closest('.order_box')).addClass('active').removeClass('fade-out');	
		$('.order_box.active img').css('display', 'none');
		$('.order_box.active .return_arrow').css('display', 'block');
		setTimeout(function() {
			$('.fade-out').css('display', 'none');
			console.log('active')
		}, 500)
		// $('.order_box a').unbind(); //para que no se active esta funcion si ya esta activa
	})


	$('.return_arrow').on('click', function(e) {
		$('.provider_box').addClass('fade-out');
		$('.order_box.fade-out').addClass('fade-in').removeClass('fade-out').css('display', 'block');
		// $('.fade-out').css('display', 'none');
		$('.order_box.active img').css('display', 'block');
		$('.order_box.active .return_arrow').css('display', 'none');
		$($(e.target).closest('.order_box')).removeClass('active');
		setTimeout(function() {
			$('.provider_box').remove();
	
		}, 500)	
		console.log('hello')
	})


// }


	// @@NEWORDER

	// encargado de mostrar y esconder el search bar
	$(document).on('keypress', function(e) {
	    var tag = e.target.tagName.toLowerCase();
	    if(e.which === 27) {
	    	hideSearchBar();
	    }
	    else if ( tag != 'input' && tag != 'textarea') {
	        displaySearchBar();
	    }
	});

	// esconde el searchbar cuando se pierde enfoque
	$('#search_bar_input').on('blur', function() {
		hideSearchBar();
	});

	// $('#search_bar_input').on('keyup', function(e) {
	// 	if (e.which === 27) {
	// 		hideSearchBar();
	// 	};
	// })



	// Arreglar tamaño de la pantalla.
	$('body').height($(window).height());

	// Para que la subcategoria tenga el efecto fade-in
	$('ul.category-list button').on('click', function(e) {
		e.preventDefault();
		categoryId = $(e.target).attr('data-category-id')
		console.log('one')
		// className = "." + e.target.textContent + "-list";
		// // indexNo = $('.category-list button:contains(\"' + e.target.textContent +'")').parent().index();
		$('.products ul').removeClass('active');
		$('.subcategories ul, .category-list button').removeClass('active');
		$('.new-order-subcategory-list[data-category-id=' + categoryId +']').addClass('active')
		// $(className).addClass('active');
		// $($(className).children()[indexNo]).css('border-left', 'none')

		$(e.target).addClass('active');		
	})

	$('.subcategories ul li button').on('click', function(e) {
		e.preventDefault();
		categoryId = $(e.target).attr('data-category-id')
		// className = "." + e.target.textContent + "-list";
		// indexNo = $('.subcategory-list button:contains(\"' + e.target.textContent +'")').parent().index();

		$('.subcategories ul li button').removeClass('active');
		$('.products ul').removeClass('active');
		$('.new-order-product-list[data-category-id=' + categoryId +']').addClass('active')


		// $(className).addClass('active');
		// $($(className).children()[indexNo]).css('border-left', 'none')

		$(e.target).addClass('active');	
	})

	// Click agrega el nombre al product_box o destruye la caja si ya esta seleccionado el prod
	$('.products button').on('click', function(e) {
		if ($(e.target).hasClass('selected_product')) {
			$('.product_box:contains('+ $(e.target).text() +')').remove();
			$(e.target).removeClass('selected_product')
			productId = $(e.target).attr('data-product-id')
			$('.order_product_history[data-order-product-id=' + productId +']').removeClass('active')
		} else {
			$('a.add_fields').click()
			productName = $(e.target).text()
			productId = $(e.target).attr('data-product-id')
			$('.order_product_history[data-order-product-id=' + productId +']').addClass('active')
			targetProductBox = $('.product_box').last()
			// agrega productId
			targetProductBox.attr('data-product-id', productId)
			targetProductBox.children('.order_product_id_field').text(productId)
			targetProductBox.children('img').attr('data-product-id', productId)
			targetProductBox.children('.comment_field').attr('data-product-id', productId)
			console.log('Added ' + productId + ' to comment');
			// cambia el nombre
			product_fields = targetProductBox.children().first()
			product_fields.text(productName)

			// obtiene seed para el comentario
			$(targetProductBox.children().get(2)).val($(e.target).attr('data-product-id'))
			orderProductId = $(targetProductBox.children('textarea').siblings().get(1)).attr('name').slice(33, 46)
			commentName = "order[order_products_attributes][" + orderProductId + "][comment_attributes][content]"
			$(targetProductBox.children('#comment_content')).attr('name', commentName)

			$(e.target).addClass('selected_product')
			console.log($(e.target))

			// para que la tacha borre al producto del formulario
			$('.product_box img.x-button').on('click', function(e) {
				targetId = $(e.target).attr('data-product-id')
				$(e.target).parent().remove()
				$('button.selected_product[data-product-id=' + targetId + ']').removeClass('selected_product')

				console.log()
			})

			// Para que aparesca el textarea animado
			$('.letter_image_box').on('click', function(e) {
				$(e.target).parent().addClass('active');
				productId = $(e.target).attr('data-product-id')
				console.log(productId)
				// setTimeout(function() {
					$('.comment_field[data-product-id=' + productId +']').addClass('editable').focus()
				// }, 1000)
				$('.comment_field[data-product-id=' + productId +']').on('blur', function(evnt) {
					$(evnt.target).removeClass('editable')
					$(e.target).parent().removeClass('active');
				})
				// setTimeout(showNewOrderTextArea(), 1000);				
			})


		}

	})



	

	// Agrega caja de producto
	$('form .add_fields').on('click', function(e) {
		time = new Date().getTime()
		regexp = new RegExp($(this).data('id'), 'g')
		$(this).before($(this).data('fields').replace(regexp, time))
		event.preventDefault()
		console.log("ran helper")
	})

	// @NEWOFFER

	// limpia la columna de informacion
	function cleanInfoTab() {
		$('.info_tab_close_button').empty()
		$('.order_title_container').empty()
		$('.order_product_info_container').empty()
		$('.order_comment_container').empty()
		$('.order_date_container').empty()
	}

	// Limpia las listas despues de cada ajax
	$('.order_box a').on('click', function() {
		$('.new_offer .offer_list').empty()
		$('.new_offer .combo_list').empty()
		$('.column.order_info').removeClass('active')
		cleanInfoTab()
		$('.order_product_info_container').append('<ul class="order_product_info_list"></ul>')
	})

	$('form .add_combo_field').on('click', function(e) {
		time = new Date().getTime()
		regexp = new RegExp($(this).data('id'), 'g')
		$(this).before($(this).data('fields').replace(regexp, time))
		event.preventDefault()
	})

 	// @admin_dashboard
 	$('.admin_dashboard .category_button').on('click', function(e) {
 		category_id = $(e.target).attr('data-category-id');
 		if ($(e.target).hasClass('active')) {
 			$(e.target).removeClass('active')
 			$(' .admin_dashboard .subcategory_button').addClass('hidden')
 			$('.admin_dashboard .edit_product').addClass('hidden')
 		} else {
 			$('.admin_dashboard .category_button').removeClass('active')
	 		$(e.target).addClass('active')
	 		$('.admin_dashboard .edit_product').addClass('hidden')
	 		$('.admin_dashboard .subcategory_button').addClass('hidden')
	 		$('.admin_dashboard .subcategory_button[data-category-id=' + category_id + ']').removeClass('hidden')
 		};
 	})

 	$('.admin_dashboard .subcategory_button').on('click', function(e) {
 		subcategory_id = $(e.target).attr('data-subcategory-id');
 		$('.admin_dashboard .subcategory_button').removeClass('active')
 		$(e.target).addClass('active')
 		$('.admin_dashboard .edit_product').addClass('hidden')
 		$('.admin_dashboard .edit_product[data-subcategory-id=' + subcategory_id + ']').removeClass('hidden')


 		// despliega el formulario para editar la subcategoria
 		$('.edit_subcategory').addClass('hidden')
 		$('.edit_subcategory[data-subcategory-id=' + subcategory_id + ']').removeClass('hidden')
 	})

})
// $(document).ready(do_on_load)
$(window).bind('page:change', do_on_load)


// $(function() {


// 	// $('.order_box a').on()
// })



// Para que calendario este en español
 // datepicker. movido a <orders/new.html.erb> por problemas de turbolinks





// Los campos requeridos muestren el mensaje indicado
function InvalidMsg(textbox) {
    
    if (textbox.value == '') {
        textbox.setCustomValidity('Obligatorio');
    }
    else if(textbox.validity.typeMismatch){
        textbox.setCustomValidity('please enter a valid email address');
    }
    else {
        textbox.setCustomValidity('');
    }
    return true;
}

function setChosenLink(link) {
	$(link).addClass('choice')
}

// despliega el search bar en la creación de ordenes
function displaySearchBar() {
	$('.product_search_box').removeClass('hidden');
	$('#search_bar_input').focus();
}

function hideSearchBar() {
	// debugger;
	$('.product_search_box').addClass('hidden');
	$('#search_bar_input').val('');
}



// object handles the indexes for the searchbar suggestion
function searchBarSuggestionHandler() {
    this.selectedIndex = null;
    this.indexes = null;
    this.newSearch = function(quantity) {
    	this.selectedIndex = 0;
    	this.indexes = quantity;
    	return 0;
    };
    this.scroll = function(direction) {
    	if (direction == 0) {
    		this.selectedIndex == 0 ? this.selectedIndex = this.indexes - 1 : this.selectedIndex = this.selectedIndex -1;
    	} else {
    		this.selectedIndex = (this.selectedIndex + 1) % this.indexes;
    	}
    	return this.selectedIndex;
    };
}
