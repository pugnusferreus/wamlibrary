var list_table;

$(document).ready(function() {

  list_table = $('#list_table').dataTable( {
    "bProcessing": true,
    "iDisplayLength": 25,
    "bServerSide": false,
    "sPaginationType": "full_numbers",
    "sAjaxSource": "/cart/tojson",
    "aoColumns": [ {"sWidth": "150px"},{"sWidth": "150px"},{"sWidth": "250px"},{ "bSortable": false, "bVisible": true,"sWidth": "150px" }]
  } );

  $("#list_table_length").hide();
});
