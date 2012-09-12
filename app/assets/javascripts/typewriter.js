$(document).ready(function (){
	$('textarea').keypress(playKeyPress);
});

keySound = new Audio('https://s3-eu-west-1.amazonaws.com/presentsinthepost/sounds/key.wav');
keySound.volume = 0.4;

function playKeyPress()
{
	if(!(keySound.currentTime == 0))
	{
		keySound.currentTime = 0;
	}
	keySound.play();
}
