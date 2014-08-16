# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	$("input.geolocation").geocomplete
	  map: "#geomap"
	  details: ".details-list",

	$("#find").click ->
		$("#geolocation").trigger("geocode")

	$("#examples a").click ->
		$("#geocomplete").val($(this).text()).trigger("geocode")
		return false

	# $(".geo-info input").keyup (e) ->
	# 	streetNumber = if $(".geo-info-street-number input").val() then $(".geo-info-street-number input").val() else ""
	# 	street = if $(".geo-info-street input").val() then $(".geo-info-street input").val() else ""
	# 	city = if $(".geo-info-city input").val() then $(".geo-info-city input").val() else ""
	# 	state = if $(".geo-info-state input").val() then $(".geo-info-state input").val() else ""
	# 	country = if $(".geo-info-country input").val() then $(".geo-info-country input").val() else ""
	# 	address = streetNumber + ", " + street + ", " + city + ", " + state + ", " + country
	# 	$("input.geolocation").val(address)
	# 	$("#geolocation").trigger("geocode")