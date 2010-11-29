var list_table;

$(document).ready(function() {

  list_table = $('#list_table').dataTable( {
    "bProcessing": true,
    "iDisplayLength": 25,
    "bServerSide": false,
    "sPaginationType": "full_numbers",
    "sAjaxSource": "/items/tojson",
    "aoColumns": [ {"sWidth": "150px"},{"sWidth": "150px"},{"sWidth": "300px"},{"sWidth": "100px"},{"sWidth": "60px"},{"sWidth": "60px"},{ "bSortable": false, "bVisible": true,"sWidth": "50px" },{ "bSortable": false, "bVisible": true,"sWidth": "50px" }]
  } );

  $("#list_table_length").hide();

  $("form").validate();
});
