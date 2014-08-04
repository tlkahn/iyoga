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
//= require turbolinks
//= require_tree .
//= require bootstrap.min
//= require angular
//= require moment-with-langs
//= require bootstrap-datetimepicker.min
//= require pickdate/picker
//= require pickdate/picker.date
//= require pickdate/picker.time
//= require bootstrap-select/bootstrap-select

$(function() {
	var top = $(".top");
	if (!!top.html().trim().length) {
		top.show().fadeOut(3000);
	}
	$('.datepicker').pickadate();
	$('.timepicker').pickatime();
	$('.selectpicker').selectpicker();
	$('.carousel').carousel({
		interval: 2000
	});
});
