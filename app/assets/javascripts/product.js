$(document).ready(function (){
	$("img[data_full_url*='uploads']").click(changeFullImage);
});

function changeFullImage()
{
	self = $(this);
	full = $('#main_product_image');
	
	temp_full = full.attr('src');
	temp_thumb = full.attr('data_thumb_url');
	
	full.attr('src', self.attr('data_full_url'));
	full.attr('data_thumb_url', self.attr('src'));
	
	self.attr('src', temp_thumb);
	self.attr('data_full_url', temp_full);
}
