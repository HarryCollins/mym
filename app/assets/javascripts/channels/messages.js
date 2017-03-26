App.messages = App.cable.subscriptions.create( {'MessagesChannel', } , {  
  received: function(data) {
  	
  	if (data.mention) {
    	alert('You have a new mention');
    }

    $('#messages_partial').append(data.message);
    $("#chat_text_area").val("");
  }

});