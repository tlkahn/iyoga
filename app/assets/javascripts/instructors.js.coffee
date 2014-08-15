# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	$("input.geolocation").geocomplete
	  map: "#geomap"
	  details: ".details-list",

	$("#find").click ->
		$("#geocomplete").trigger("geocode")

	$("#examples a").click ->
		$("#geocomplete").val($(this).text()).trigger("geocode")
		return false
