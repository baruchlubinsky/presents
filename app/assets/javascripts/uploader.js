$(document).ready(function (){
	$('form').submit( function(){ $('.hidden').html(''); });
});

var count = 0;
var place_holder = 999;

function addFile()
{
	temp = $('#upload_template').html();
	patt = new RegExp(place_holder, 'g');
	temp = temp.replace(patt, count++);
	$('#upload_container').append(temp);
}
