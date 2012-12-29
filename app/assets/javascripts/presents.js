$(document).ready(function (){
	//$('#order_options_recipient').change(loadOptions);
	$('#options_recipient').change(showOptions);
	$('#options_recipient').change();
	$('#order_options_gift').change(toggleMessage);
	$('#order_options_gift').change();
});


function loadOptions()
{
	$.get('/presents/' + $('#order_options_recipient option:selected').val() + '.js', function(data) {eval(data);} );
}

function showOptions(event)
{
	$('#choices_container').children().each(function(){$(this).addClass('hidden');});
	$('#choices_' + this.selectedIndex).removeClass('hidden');
}

function toggleMessage()
{
	if(this.checked)
	{
		$('#message').removeClass('hidden');
		$('#order_options_delivery_address_0').addClass('required');
		$('#order_options_delivery_address_post_code').addClass('required');
		$('#order_options_to').addClass('required');
		$('#order_options_from').addClass('required');
	}
	else
	{
		$('#message').addClass('hidden');
		$('#order_options_delivery_address_0').removeClass('required');
		$('#order_options_delivery_address_post_code').removeClass('required');
		$('#order_options_to').removeClass('required');
		$('#order_options_from').removeClass('required');
	}
}
