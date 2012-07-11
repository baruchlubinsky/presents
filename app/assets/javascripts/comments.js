$(document).ready(function (){
	if(window.location.hash == '#comments')
	{
		toggleComments(window.location.pathname.split('/').pop());
	}
});

function toggleComments(id)
{
	$('#' + id + '_comments').slideToggle();
}
