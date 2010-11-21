var list_table;

$(document).ready(function() {

  list_table = $('#list_table').dataTable( {
    "bProcessing": true,
    "iDisplayLength": 25,
    "bServerSide": false,
    "sPaginationType": "full_numbers",
    "sAjaxSource": "/listings/" + $("#sub_category_id").val() + "/tojson",
    "aoColumns": [ {"sWidth": "150px"},{"sWidth": "150px"},{"sWidth": "100px"},{"sWidth": "200px"},{"sWidth": "100px"},{ "bSortable": false, "bVisible": true,"sWidth": "80px" }]
  } );

  $("#list_table_length").hide();
});
