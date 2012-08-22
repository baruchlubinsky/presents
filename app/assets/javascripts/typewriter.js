$(document).ready(function (){
	$('textarea').keypress(playKeyPress);
});

keySound = new Audio(SERVER_HTTP_HOST() + '/sounds/key.wav');

function playKeyPress()
{
	if(!(keySound.currentTime == 0))
	{
		keySound.currentTime = 0;
	}
	keySound.play();
}

function SERVER_HTTP_HOST(){  
    var url = window.location.href;  
    url = url.replace("http://", "");   
      
    var urlExplode = url.split("/");  
    var serverName = urlExplode[0];  
      
    serverName = 'http://'+serverName;  
    return serverName;  
}