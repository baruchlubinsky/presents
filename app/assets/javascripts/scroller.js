$(document).ready(function (){
	maxScroll = parseInt($('#scroller').attr('data_items_count')) - 3;
	scrollCount = 0;
	scrollTimer = setInterval(animateScroller, 4000);
	
	$('#scroller_container').mouseenter(function(){clearInterval(scrollTimer);});
	$('#scroller_container').mouseleave(function(){scrollTimer = setInterval(animateScroller, 4000);});
});

var maxScroll;
var scrollCount;
var scrollTimer;

function animateScroller()
{
	scroller = $('#scroller');
	if(scrollCount <= maxScroll)
	{
		scrollCount++;
		scroller.animate(
			{left: -scrollCount * 217.5},
			1200,
			'swing');
	}
	else
	{
		scrollCount = 0;
		scroller.animate(
			{left: '0'},
			400,
			'swing');
	}
}
