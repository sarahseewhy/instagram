$(document).ready(function(){
	var map = $('#map');

	$.get(map.data('post-url'), function(post) {
		
		var map = new GMaps({
		  div: '#map',
		  lat: post.latitude,
		  lng: post.longitude 
		});

		map.addMarker({
		  lat: post.latitude,
		  lng: post.longitude, 
		  title: post.description
		});
	})	
})


