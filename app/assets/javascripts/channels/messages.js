App.messages = App.cable.subscriptions.create('MessagesChannel', {  
  received: function(data) {
    $('#messages_partial').append(this.renderMessage(data));
    $("#chat_text_area").val("");
  },

  renderMessage: function(data) {
    return "<p> <b>" + data.user + ": </b>" + data.message + "</p>";
  }
});