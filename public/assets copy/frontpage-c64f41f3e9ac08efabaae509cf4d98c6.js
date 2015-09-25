
var do_on_load = function() { 
	console.log('first')
	$(window).load(function(){
		console.log('second')
		$('.loading_screen').remove()
		if ($('p.alert').text() == "") {
			$('p.alert').css('display', "none")
		};

		$('#square3').on('click', function(e) {
			console.log('click')
			$('#square3 a')[0].click();
		})

		$('.frontpage-square a').on('click', function(e) {
			e.stopImmediatePropagation();
		})

		$(".frontpage-square").on({
		    mouseenter: function (e) {
		        //stuff to do on mouse enter
				$(e.target).parent().siblings('img').addClass('hover')
		    },
		    mouseleave: function (e) {
		        //stuff to do on mouse leave
				$(e.target).parent().siblings('img').removeClass('hover')
		    }
		});

		$('form#new_user').on('keypress', function(e) {
			console.log('keypress')
			if(e.which == 13) {
		        $('form.new_user').submit();
		    }
		})
	})
}




$(document).ready(do_on_load)
$(window).bind('page:change', do_on_load)
;
