function toggleBtnNotification() {
  var btn = document.getElementById('btn-notify');
  var content = document.getElementById('dropdown-content');
  btn.onclick = function() {
    content.style.display = 'block';
    btn.style.color = '$black';
    $.ajax({
      url: "notifications/refresh_part"
    });
  };
  window.onclick = function(event) {
    if (event.target != btn) {
        content.style.display = 'none';
        btn.style.color = '$main_background';
    }
  }
}
