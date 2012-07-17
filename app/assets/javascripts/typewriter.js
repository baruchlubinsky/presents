$(document).ready(function (){
	$('textarea').keypress(playKeyPress);
});

keySound = new Audio('../sounds/key.wav');

function playKeyPress()
{
	if(!(keySound.currentTime == 0))
	{
		keySound.currentTime = 0;
	}
	keySound.play();
}

