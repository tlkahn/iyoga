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
//
//= require jquery
//= require jquery_ujs
//= require underscore/underscore
//= require angular

//= require moment/moment
//= require moment-timezone/builds/moment-timezone-with-data-2010-2020
//= require jstz/jstz

//= require_tree .

//= require bootstrap
//= require bootstrap-datetimepicker/src/js/bootstrap-datetimepicker
//= require pickdate/picker
//= require pickdate/picker.date
//= require pickdate/picker.time
//= require bootstrap-select/bootstrap-select

//= require geocomplete/jquery.geocomplete

//= require typeahead/bloodhound
//= require typeahead/typeahead.bundle
//= require typeahead/typeahead.jquery

//= require bootstrap-switch/dist/js/bootstrap-switch
//= require bootstrap-datepicker/js/bootstrap-datepicker
//= require bootstrap-slider/dist/bootstrap-slider.min

//= require fullcalendar/dist/fullcalendar



$(function() {
  if ($(".alert-warning").html().trim().length === 0) {
    $(".alert-warning").hide();
  }
  else {
    window.setTimeout(function() { $(".alert-warning").alert('close'); }, 2000);
  }
  $("a[rel~=popover], .has-popover").popover();
  $("a[rel~=tooltip], .has-tooltip").tooltip();
  $(".bootstrap-checkbox button").css({
    "outline": "none"
  });

  $('.datepicker').datepicker();

  $('.selectpicker').selectpicker();

  $('.input-group.date').datepicker().on('changeDate', function(e){
        console.log("date changed to", e);
        $(document).trigger("current_date_changed", moment(e.date))
    });

  $(document).on('current_date_modified', function(e, date) {
    $('.input-group.date').datepicker('update', date.toDate())
  })

  $(document).on('toggleCalendarView', function(e, show, $elem) {
    if (!show) {
      $('.input-group.date').show();
    }
    else
      $('.input-group.date').hide();
    show = !show;
    $elem.data('show', show);
  })

  $(window).on('focus', function(event) {
    $('.show-focus-status > .alert-danger').addClass('hidden');
    $('.show-focus-status > .alert-success').removeClass('hidden');
  }).on('blur', function(event) {
    $('.show-focus-status > .alert-success').addClass('hidden');
    $('.show-focus-status > .alert-danger').removeClass('hidden');
  });

  $('.date-picker').each(function () {
    var $datepicker = $(this),
    cur_date = ($datepicker.data('date') ? moment($datepicker.data('date'), "YYYY/MM/DD") : moment()),
    format = {
      "weekday" : ($datepicker.find('.weekday').data('format') ? $datepicker.find('.weekday').data('format') : "dddd"),
      "date" : ($datepicker.find('.date').data('format') ? $datepicker.find('.date').data('format') : "MMMM Do"),
      "year" : ($datepicker.find('.year').data('year') ? $datepicker.find('.weekday').data('format') : "YYYY")
    };

    function updateDisplay(cur_date) {
      $datepicker.find('.date-container > .weekday').text(cur_date.format(format.weekday));
      $datepicker.find('.date-container > .date').text(cur_date.format(format.date));
      $datepicker.find('.date-container > .year').text(cur_date.format(format.year));
      $datepicker.data('date', cur_date.format('YYYY/MM/DD'));
      // $datepicker.find('.input-datepicker').removeClass('show-input');
    }

    updateDisplay(cur_date);

    $(document).on('current_date_changed', function(e, date) {
      if (!date) {
        updateDisplay(moment())
      }
      else
        updateDisplay(date);
    })

    $datepicker.on('click', '[data-toggle="calendar"]', function(event) {
      event.preventDefault();
      show = $(this).data('show') == true
      $elem = $(this);
      $(document).trigger('toggleCalendarView', [show, $elem]);
    });

    $datepicker.on('click', '.input-datepicker > .input-group-btn > button', function(event) {
      event.preventDefault();
      var $input = $(this).closest('.input-datepicker').find('input'),
      date_format = ($input.data('format') ? $input.data('format') : "YYYY/MM/DD");
      if (moment($input.val(), date_format).isValid()) {
       updateDisplay(moment($input.val(), date_format));
     }else{
      alert('Invalid Date');
    }
  });

    $datepicker.on('click', '[data-toggle="datepicker"]', function(event) {
      event.preventDefault();

      var cur_date = moment($(this).closest('.date-picker').data('date'), "YYYY/MM/DD"),
      date_type = ($datepicker.data('type') ? $datepicker.data('type') : "days"),
      type = ($(this).data('type') ? $(this).data('type') : "add"),
      amt = ($(this).data('amt') ? $(this).data('amt') : 1);

      if (type == "add") {
        cur_date = cur_date.add(date_type, amt);
      }else if (type == "subtract") {
        cur_date = cur_date.subtract(date_type, amt);
      }

      updateDisplay(cur_date);
      $(document).trigger('current_date_modified', cur_date)
    });

    // if ($datepicker.data('keyboard') == true) {
    //   $(window).on('keydown', function(event) {
    //     if (event.which == 37) {
    //       $datepicker.find('span:eq(0)').trigger('click');
    //     }else if (event.which == 39) {
    //       $datepicker.find('span:eq(1)').trigger('click');
    //     }
    //   });
    // }
  });
})