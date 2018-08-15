$(document).on('turbolinks:load', function() {
  $('.contact').click(function() {
    id = $(this).closest("li").data("id");
    var chatUrl = "/messages";
    $.ajax({
      url: chatUrl,
      data: {id: id}
    });
  });
});

function autoScrollChat() {
  $('#messages').animate({scrollTop: $('#messages').get(0).scrollHeight}, 0);
}
