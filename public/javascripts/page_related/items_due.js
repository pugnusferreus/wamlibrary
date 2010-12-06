var list_table;

$(document).ready(function() {

  list_table = $('#list_table').dataTable( {
    "bProcessing": true,
    "iDisplayLength": 25,
    "bServerSide": false,
    "sPaginationType": "full_numbers",
    "sAjaxSource": "/items_due/tojson",
    "aoColumns": [ {"sWidth": "120px"},{"sWidth": "100px"},{"sWidth": "100px"},{"sWidth": "80px"},{"sWidth": "100px"},{ "bSortable": false, "bVisible": true,"sWidth": "30px" }]
  } );

  $("#list_table_length").hide();

  $("form").validate();
});
