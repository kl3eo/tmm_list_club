;(function($){
    "use strict"
	
/*	
    $('.counter').counterUp({
		delay: 10,
		time: 1000
    });
*/	
	
    $(".skill_main").each(function() {
        $(this).waypoint(function() {
            var progressBar = $(".progress-bar");
            progressBar.each(function(indx){
                $(this).css("width", $(this).attr("aria-valuenow") + "%")
            })
        }, {
            triggerOnce: true,
            offset: 'bottom-in-view'

        });
    });


//console.log('ha')	
})(jQuery)
