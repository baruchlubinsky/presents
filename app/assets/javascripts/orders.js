$(document).ready(function (){
	$('input[data_trigger_submit]').change(ajaxSubmit);
});

function ajaxSubmit()
{
	$(this.form).submit();

}
