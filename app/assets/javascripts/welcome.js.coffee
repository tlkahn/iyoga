# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



$(document).on "ready page:load", ->

	$('.selectpicker').selectpicker();
	$('.multiselect').multiselect();

	oldDate = ""
	oldFrom = ""
	oldTo = ""
	oldSearchLocation = ""
	newDate = ""
	newFrom = ""
	newTo = ""
	newSearchLocation = ""
	oldStyle = $(".style-wrapper .filter-option").html()
	oldLevel = $(".level-wrapper .filter-option").html()

	stateCheckInterval = 500

	if $(".welcome-title").length > 0
		setInterval ->
			newDate = if $(".datepicker-wrap form input") && $(".datepicker-wrap form input").length then $(".datepicker-wrap form input").val() else ""
			newFrom = if $(".timepicker-wrap form .timepicker") && $(".timepicker-wrap form .timepicker").length then $(".timepicker-wrap form .timepicker")[0].value else ""
			newTo = if $(".timepicker-wrap form .timepicker") && $(".timepicker-wrap form .timepicker").length then $(".timepicker-wrap form .timepicker")[1].value else ""
			newSearchLocation = if $(".search-location") && $(".search-location").length then $(".search-location").val() else ""
			newStyle = if $(".style-wrapper .filter-option") && $(".style-wrapper .filter-option").length then $(".style-wrapper .filter-option").html() else ""
			newLevel = if $(".level-wrapper .filter-option") && $(".level-wrapper .filter-option").length then $(".level-wrapper .filter-option").html() else ""

			unless newDate is oldDate
				$(document).trigger("dateChanged", [newDate])
				oldDate = newDate
			unless newFrom is oldFrom
				$(document).trigger("fromChanged", [newFrom])
				oldFrom = newFrom
			unless newTo is oldTo
				$(document).trigger("toChanged", [newTo])
				oldTo = newTo
			unless newSearchLocation is oldSearchLocation
				$(document).trigger("searchLocationChanged", [newSearchLocation])
				oldSearchLocation = newSearchLocation
			unless newStyle is oldStyle
				$(document).trigger("styleChanged", [newStyle])
				oldStyle = newStyle
			unless newLevel is oldLevel
				$(document).trigger("levelChanged", [newLevel])
				oldLevel = newLevel
		, stateCheckInterval

	$(document).on "dateChanged", (e, newDate) ->
		$("#date-value").val(newDate)

	$(document).on "fromChanged", (e, newFrom) ->
		$("#from-value").val(newFrom)

	$(document).on "toChanged", ->
		$("#to-value").val(newTo)

	$(document).on "searchLocationChanged", (e, newSearchLocation) ->
		$("#location-value").val(newSearchLocation)

	$(document).on "styleChanged", (e, newStyle) ->
		$("#style-value").val(newStyle)

	$(document).on "levelChanged", (e, newLevel) ->
		$("#level-value").val(newLevel)
