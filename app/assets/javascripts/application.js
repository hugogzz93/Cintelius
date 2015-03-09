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
})
