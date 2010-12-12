$(document).ready(function() {
  $('.main_menu').hide();
  $('#[id^=navigation_link_]').click(function(){
    $('#' + this.id.replace("link_","")).toggle();
  });

  $('#header_content').corner();
  $('.text_box_wrapper').corner();
  $('.text_area_wrapper').corner();


});