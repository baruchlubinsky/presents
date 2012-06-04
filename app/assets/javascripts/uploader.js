$(document).ready(function (){
	$('input[name*="blog_images"]').change(nextFile);
});

var count = 0;

function nextFile()
{
	temp = $('#upload_template').html();
	patt = new RegExp(999, 'g');
	temp = temp.replace(patt, ++count);
	$('#upload_container').append(temp);
	$('input[name*="blog_images"]').change(nextFile);
}
