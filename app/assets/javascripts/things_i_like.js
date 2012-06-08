$(document).ready(function (){

	$("form").bind("ajax:success", function(event, data) {
		var response = eval(data);
		setLargeImage(response.image.file.large.url);
	});
	
	

});

$(window).load(function(){

	var $container = $('#container');
	$container.imagesLoaded(function(){
  		$container.masonry({
    	itemSelector : '.card'
  		});
	});


});

function setLargeImage(image)
{
	$('#large_image').attr('src', image);
	$('#full_page').removeClass('hidden');
	$('#full_page').click(function(){$('#full_page').addClass('hidden')});
}



