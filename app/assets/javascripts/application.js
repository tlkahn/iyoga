// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs

//= require underscore/underscore
//= require moment/moment

//= require_tree .
//= require angular
//= require moment-with-langs
//= require bootstrap
//= require bootstrap-datetimepicker.min
//= require pickdate/picker
//= require pickdate/picker.date
//= require pickdate/picker.time
//= require bootstrap-select/bootstrap-select
//= require bootstrap-multiselect
//= require geocomplete/jquery.geocomplete
//= require typeahead/bloodhound
//= require typeahead/typeahead.bundle
//= require typeahead/typeahead.jquery

//= require bootstrap-switch/dist/js/bootstrap-switch
//= require bootstrap-checkbox/js/bootstrap-checkbox
//= require bootstrap-datepicker/js/bootstrap-datepicker

//= require fullcalendar/dist/fullcalendar
//= require moment-timezone/builds/moment-timezone-with-data-2010-2020
//= require jstz/jstz


// +(function() {
// 	var top = $(".top");
// 	if (!!top.html().trim().length) {
// 		top.show().delay(3000).fadeOut(1000, 'linear');
// 	}
// 	var dismiss = '[data-dismiss="alert"]';
// 	$(document).on('close.bs.alert', function() {
// 		top.hide();
// 	});

  $(function() {
    if ($(".alert-warning").html().trim().length === 0) {
      $(".alert-warning").hide();
    }
    else {
      window.setTimeout(function() { $(".alert-warning").alert('close'); }, 2000);
    }
    $("a[rel~=popover], .has-popover").popover();
    $("a[rel~=tooltip], .has-tooltip").tooltip();
    $('input[type="checkbox"]').checkbox();
    $(".bootstrap-checkbox button").css({
      "outline": "none"
    })

    $('.bsdatepicker').datepicker({
      startDate: new Date()
    })

    console.log(jstz.determine().name());
  })

// })();