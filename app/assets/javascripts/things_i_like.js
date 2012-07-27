$(document).ready(function(){
	$('img[data_full_size]').click(setLargeImage);
});

$(window).load(function(){

	var $container = $('.card_container');
	$container.imagesLoaded(function(){
  		$container.masonry({
    	itemSelector : '.card'
  		});
	});


});

function setLargeImage(event)
{
	alert('event');
	$('#large_image').attr('src', $(event.target).attr('data_full_size'));
	$('#full_page').removeClass('hidden');
	$('#full_page').click(function(){$('#full_page').addClass('hidden')});
}

/* AJAX Version
$(document).ready(function (){

	$("form.edit_thing").bind("ajax:success", function(event, data) {
		var response = eval(data);
		setLargeImage(response.image.file.large.url);
	});
	
	

});



function setLargeImage(image)
{
	$('#large_image').attr('src', image);
	$('#full_page').removeClass('hidden');
	$('#full_page').click(function(){$('#full_page').addClass('hidden')});
}
*/