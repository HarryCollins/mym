// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/



$(document).ready(function() {


});

//the below only fires on markets#edit and markets#new
$(".markets.edit, .markets.new").ready(function() {
    $("#add_outcome").click(function() {

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

    //grab status of 'publish' checkbox, for testing on submit
    var pub_checkbox = 0;
    if ($("#publish_checkbox").prop("checked")) {
        pub_checkbox = 1;
    }
    else {
        pub_checkbox = 0;
    }

    //test if market status has gone from not published to published - give warning if so
    $('#market_form').submit(function(e) {
        if (pub_checkbox == 0 && $("#publish_checkbox").prop("checked")) {
            if (!confirm('Are you sure that you want to publish this market? Once published, bets can be made and any once a bet is made, the market cannot be edited (with this exception of creating additional outcomes).')) {
                return false;
            }
        }
    });

});

//$("<%= escape_javascript(render @market) %>").appendTo("#ajax");

//the below only fires on markets#index

//remove active class from all_markets tab and add to selected tab
$(".markets.index").ready(function() {
    var joined_query_string = getParameterByName('joined');
    var joined_and_complete_query_string = getParameterByName('joinedandcomplete');

    if (!!joined_query_string) {
        $("li.active").removeClass("active");
        $('#joined_markets').addClass('active');
    }
    else if (!!joined_and_complete_query_string) {
        $("li.active").removeClass("active");
        $('#joined_and_complete_markets').addClass('active');
    }
    else {
        $('#all_markets').addClass('active');
    }
});


//the below only fires on markets#show
$(".markets.show").ready(function() {

    cableSubscribe(getMarketID(), getUserID());

});

//the below only fires on markets#results
$(".markets.results").ready(function() {


});

//functions
function getParameterByName(name, url) {
    if (!url) {
        url = window.location.href;
    }
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}

function getMarketID() {
    return $("#market_show_id").attr('data-category');
}

function getUserID() {
    return $("#user_show_id").attr('data-category');
}

//Action Cable functions
function cableSubscribe(marketID, userID) {
    App.messages = App.cable.subscriptions.create({
        channel: 'MarketsChannel',
        market: marketID,
        user: userID
    }, {
        received: function(data) {

            // mention in message (any market)
            if (data.mention) {
                alert('You have a new mention from ' + data.from_user + ' in the market "' + data.market + '"');
            }

            // new message in market
            if (data.new_message) {
                $('#messages_partial').append(data.message);
                if (data.user_id == getUserID()) {
                    $('#chat_text_area').val('');
                }
            }

            // user joined or left market
            if (data.user_partial) {
                $("#user_partial").html(data.user);
            }

            // when a hit occurs in market
            if (data.back_partial) {
                $("#userbacks_partial").html(data.open_bets);
                $("#userback_hits_partial").append(data.new_hit);
            }

            // when a hit is created in market
            if (data.lay_partial) {
                $("#userlays_partial").html(data.open_bets);
                $("#userlay_hits_partial").append(data.new_hit);
            }

            // when a lay or back is created in market
            if (data.mo_partial) {
                $("#mo_" + data.mo_id).html(data.mo);
            }

            // when market is completed or page needs to be reloaded
            if (data.reload_page) {
                location.reload();
            }

        }

    });
}
