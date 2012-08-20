$(document).ready(function (){
	//$('#order_options_recipient').change(loadOptions);
	$('#order_options_recipient').change(showOptions);
	$('#order_options_recipient').change();
	$('#order_options_gift').change(toggleMessage);
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
	}
	else
	{
		$('#message').addClass('hidden');
	}
}
