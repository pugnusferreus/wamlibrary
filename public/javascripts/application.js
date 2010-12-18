$(document).ready(function() {
  $('.main_menu').hide();
  $('#[id^=navigation_link_]').click(function(){
    $('#' + this.id.replace("link_","")).toggle();
  });
  $.ajaxSettings.cache = false;
});