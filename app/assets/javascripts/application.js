// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require jquery_ujs
//= require activestorage
//= require turbolinks
// require turbo
//= require bootstrap-sprockets
//= require bootstrap-multiselect
//= require jquery.plugin
//= require jquery.countdown.min
//= require tooltipster
//= require dataTables/jquery.dataTables
// require nprogress
// require nprogress-turbolinks
//= require chartkick
// require Chart.bundle
//= require highcharts
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

  $('#payment_table').dataTable({
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

  $('#leaderboard').dataTable({
    'iDisplayLength': 50,
    searching: false,
    "columnDefs": [ { "searchable": false, "orderable": false, "targets": [0] } ],
    "order": [[ 2, "desc" ]],
    "fnRowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
      var index = iDisplayIndexFull + 1;
      $("td:first", nRow).html(index);
      return nRow;
    }
  });

  $('#challenge_select, #user_select').multiselect({
    includeSelectAllOption: true,
    enableCaseInsensitiveFiltering: true,
    nonSelectedText: 'Select',
    numberDisplayed: 2,
    buttonWidth: '300px',
    maxHeight: 400
  });

  $('#select_prediction_match').change(function() {
    var match_id = $('#select_prediction_match').val();
    var tournament_id = $('#current_tournament_id').val();
    $.ajax({
      type: 'GET',
      dataType: 'script',
      url: '/tournaments/' + tournament_id + '/show_prediction_graph',
      data: { match_id: match_id }
    });
  });

  $('#select_prediction_match_question').change(function() {
    var match_id = $('#select_prediction_match_question').val();
    var tournament_id = $('#current_tournament_id').val();
    $.ajax({
      type: 'GET',
      dataType: 'script',
      url: '/tournaments/' + tournament_id + '/show_match_questions',
      data: { match_id: match_id }
    });
  });

  $('#edit_prediction_match_user, #edit_prediction_match').change(function() {
    var match_id = $('#edit_prediction_match').val();
    var user_id = $('#edit_prediction_match_user').val();
    var tournament_id = $('#current_tournament_id').val();
    $.ajax({
      type: 'GET',
      dataType: 'script',
      url: '/tournaments/' + tournament_id + '/select_predictions_for_user',
      data: { match_id: match_id, selected_user_id: user_id }
    });
  });
});
