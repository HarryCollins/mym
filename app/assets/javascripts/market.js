// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/



$( document ).ready(function() {

	$("#add_outcome").click(function(){
	    
        //create Date object 
        var date = new Date();
        
        //get number of milliseconds since midnight Jan 1, 1970  
        //and use it for address key 
        var mSec = date.getTime();
        
        //Replace 0 with milliseconds 
        idAttributOutcome = "market_market_outcomes_attributes_0_outcome".replace("0", mSec);
        nameAttributOutcome = "market[market_outcomes_attributes][0][outcome]".replace("0", mSec);
            
        $("#new_outcomes_input_group").append('<li><input type="text" placeholder="New Outcome" name=' + nameAttributOutcome + ' id=' + idAttributOutcome + '></li>');
        
	});
	
});

