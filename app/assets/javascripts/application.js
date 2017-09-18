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
//= require jquery
//= require jquery_ujs
//= require select2
//= require dataTables/jquery.dataTables
//= require bootstrap
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require cookies_eu
//= require turbolinks
//= require_tree .

$(document).ready(function() {
    $('.classifieds-table').DataTable();
  });


// $(document).ready(function() { $('#ville').select2(); });
// $(document).ready(function() { $('#number_of_guests').select2(); });

// $(document).ready(function() {
//   $( "select[name='number_of_guests']" ).change(function() {
//     $( "select option:selected" ).each(function() {
//     });
//     alert( 'clicked' );
//   })
//   .trigger( "change" );
// });