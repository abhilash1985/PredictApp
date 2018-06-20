// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require bootstrap-multiselect
//= require jquery.countdown
//= require tooltipster
//= require dataTables/jquery.dataTables
//= require nprogress
//= require nprogress-turbolinks
//= require_tree .

$(document).ready(function () {
  setTimeout(function() {
    $('.alert').fadeOut(500);
  }, '800');
  $('.check').tooltipster();

  $('#point_table').dataTable({
    'iDisplayLength': 30,
    searching: false,
    "columnDefs": [ { "searchable": false, "orderable": false, "targets": [0] } ],
    "order": [[ 2, "desc" ]],
    "fnRowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
      var index = iDisplayIndexFull + 1;
      $("td:first", nRow).html(index);
      return nRow;
    }
  });

  $('#match_prediction_0, #match_prediction_1, #match_prediction_2').dataTable({
    'iDisplayLength': 30,
    searching: false, paging: false, bInfo: false,
    "columnDefs": [ { "searchable": false, "orderable": false, "targets": [0, 4, 5, 6, 7, 8] } ],
    "order": [[ 2, "desc" ]],
    "fnRowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
      var index = iDisplayIndexFull + 1;
      $("td:first", nRow).html(index);
      return nRow;
    }
  });

  $('#payment_table, #challenge_payment_table').dataTable({
    'iDisplayLength': 50,
    searching: false,
    "columnDefs": [ { "searchable": false, "orderable": false, "targets": [0] } ],
    "order": [[ 1, "asc" ]],
    "fnRowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
      var index = iDisplayIndexFull + 1;
      $("td:first", nRow).html(index);
      return nRow;
    }
  });
});
