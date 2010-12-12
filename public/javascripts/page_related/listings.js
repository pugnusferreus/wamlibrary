var list_table;

$(document).ready(function() {

  list_table = $('#list_table').dataTable( {
    "bProcessing": true,
    "iDisplayLength": 25,
    "bServerSide": false,
    "sPaginationType": "full_numbers",
    "sAjaxSource": "/listings/" + $("#sub_category_id").val() + "/tojson",
    "aoColumns": [ {"sWidth": "100px"},{"sWidth": "100px"},{"sWidth": "100px"},{"sWidth": "300px"},{"sWidth": "100px"},{ "bSortable": false, "bVisible": true,"sWidth": "80px" }]
  } );

  $("#list_table_length").hide();
  $("#navigation_" + $("#category_id").val()).show()

  //need to hack data tables abit to give it rounded edge
  //if data tables exists, means there's no form
  if($("#list_table_filter").children().length != 0) {
    $("#list_table_filter").children().addClass('text_box');  
    $("#list_table_filter").append("<div class='text_box_wrapper'></div>");
    $('.text_box_wrapper').corner();
    $(".text_box_wrapper").prepend($(".text_box"));
  }
});
