$(document).ready(function (){
	$('#order_options_recipient').change(loadOptions);
	$('#order_options_gift').change(toggleMessage);
});


function loadOptions()
{
	$.get('/presents/' + $('#order_options_recipient option:selected').val() + '.js', function(data) {eval(data);} );
}

function toggleMessage()
{
	if(this.checked)
	{
		$('#message').removeClass('hidden');
	}
	else
	{
		$('#message').addClass('hidden');
	}
}
