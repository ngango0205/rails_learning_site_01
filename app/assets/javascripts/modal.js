$(function(){
  var modals = document.getElementsByClassName('modal');
  window.onclick = function(event) {
    var i;
    for (i = 0; i < modals.length; i++){
      var modal = modals[i];
      if (event.target == modal) {
          modal.style.display = "none";
      }
    }
  }
})
