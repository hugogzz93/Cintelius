
var do_on_load = function() { 
	$(window).load(function(){
		$('.loading_screen').remove()
		if ($('p.alert').text() == "") {
			$('p.alert').css('display', "none")
		};

		$(".frontpage-square").on({
		    mouseenter: function (e) {
		        //stuff to do on mouse enter
				$(e.target).parent().siblings('img').addClass('hover')
				console.log(e.target)
		    },
		    mouseleave: function (e) {
		        //stuff to do on mouse leave
				$(e.target).parent().siblings('img').removeClass('hover')
				console.log('leave')
		    }
		});
	})
}

$('form.new_user').on('keypress', function(e) {
	if(e.which == 13) {
        $('form.new_user').submit();
    }
})


$(document).ready(do_on_load)
$(window).bind('page:change', do_on_load)