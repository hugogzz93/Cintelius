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
//= require jquery-ui/datepicker
//= require turbolinks
//= require_tree .


var do_on_load = function() { 

	// $('.top-bar a').on('click', function(e) {
	// 	$('choice').removeClass('choice')
	// 	$(e.target).addClass('choice')
	// 	console.log('added choice')
	// })



	$('#new_order_form_continue_button').on('click', function(e) {
		e.preventDefault();
		$('.new_order_pop_up_screen').addClass('active')
		$('.product_form_area').addClass('active')
		$('#new_order_form_continue_button').css('display', 'none')
	})

	$('#new_order_submit').on('click', function() {
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
		console.log('clicked')
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
			productId = $(e.target).attr('data-product-id')
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

	// Limpia las listas despues de cada ajax
	$('.order_box a').on('click', function() {
		$('.new_offer .offer_list').empty()
		$('.new_offer .combo_list').empty()
	})

	$('form .add_combo_field').on('click', function(e) {
		time = new Date().getTime()
		regexp = new RegExp($(this).data('id'), 'g')
		$(this).before($(this).data('fields').replace(regexp, time))
		event.preventDefault()
	})

  // do some things 
}
$(document).ready(do_on_load)
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
	console.log('asdfasdf')
}



