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
	$('#large_image').attr('src', $(event.target).attr('data_full_size'));
	if($(event.target).attr('data_source'))
	{
		url = $(event.target).attr('data_source');
		label = $(event.target).attr('data_source_label');
		if(label == undefined)
		{
			label = url;
		}
		$('#source').html("<a href=" + url + ">" + label + "</a>");
	}
	$('#full_page').removeClass('hidden');
	$('#full_page').click(function(){$('#full_page').addClass('hidden');$('#source').html("");});
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