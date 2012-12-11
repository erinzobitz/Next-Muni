(function($, window){
	window.Muni = window.Muni || {};
	var Geocode = Muni.Geocode = {
		init: function() {
			$('form').on('click', '#submit', Geocode.getCoords)
		}
		, getCoords: function(e) {
			e.preventDefault();
			$.ajax(url, {data: JSON.stringify(data)})
				.done(function(response){
					//do stuff when you get data back
				})
				.fail(function(xhr){
					//do stuff when stuff breaks
				})
			;
		}
	}
	$(function(){
		Geocode.init();
	});
	$.ajaxSetup({
		type: 'POST'
		, dataType: 'json'
	})
})(jQuery, window);