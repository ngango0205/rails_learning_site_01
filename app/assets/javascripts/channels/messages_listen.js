$(function() {
  message_listen();
});

function message_listen(){
  var $messages, $new_message_body, $new_message_form, $room_id;
  $messages = $('#messages');
  $room_id = $messages.closest("div").data("id");
  $new_message_form = $('#new-message');
  $new_message_body = $new_message_form.find('#message-body');
  if ($messages.length > 0) {
    App.chat = App.cable.subscriptions.create({
      channel: "ChatChannel"
    }, {
      connected: function() {},
      disconnected: function() {},
      received: function(data) {
        if (data['message']) {
          $new_message_body.val('');
          $messages.append(data['message']);
          return autoScrollChat();
        }
      },
      send_message: function(message) {
        return this.perform('send_message', {
          message: message,
          room_id: $room_id
        });
      }
    });
    return $new_message_form.submit(function(e) {
      var $this, message_body;
      $this = $(this);
      message_body = $new_message_body.val();
      if ($.trim(message_body).length > 0) {
        App.chat.send_message(message_body);
      }
      e.preventDefault();
      return false;
    });
  }
}
