$(document).ready(function (){
	maxScroll = parseInt($('#scroller').attr('data_items_count'));
	scrollCount = 0;
	scrollTimer = setInterval(animateScroller, 3000);
	
	$('#scroller_container').mouseenter(function(){clearInterval(scrollTimer);});
	$('#scroller_container').mouseleave(function(){scrollTimer = setInterval(animateScroller, 3000);});
});

var maxScroll;
var scrollCount;
var scrollTimer;

function animateScroller()
{
	scroller = $('#scroller');
	if(scrollCount == maxScroll)
	{
		scroller.css('left', 0);
		scrollCount = 0;
	}
	scrollCount++;
	scroller.animate(
					{left: -scrollCount * 217.5},
					1200,
					'swing');
}
