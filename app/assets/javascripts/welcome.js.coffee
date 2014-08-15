# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "ready page:load", ->
	$(".pull-down-menu").hide()

	$(".account-menu ul li a").hover ->
		$(@).parent().addClass("active")
	, ->
		$(@).parent().removeClass("active")

	pullDowntoggle = false

	$("a.pull-down").click (e) ->
		e.preventDefault()
		e.stopPropagation()
		pullDowntoggle = !pullDowntoggle
		$(document).trigger("pullDownToggleChanged")

	$(document).on('pullDownToggleChanged', ->
		if pullDowntoggle
			$(".pull-down-menu").show()
		else
			$(".pull-down-menu").hide()
	)

	$("html").click (event) ->
		target = $(event.target)
		if (target.parents(".pull-down-menu").length == 0 and target.parents(".pull-down-button").length == 0)
			pullDowntoggle = false
			$(".pull-down-menu").toggle(pullDowntoggle)

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
			newDate = $(".datepicker-wrap form input").val()
			newFrom = $(".timepicker-wrap form .timepicker")[0].value
			newTo = $(".timepicker-wrap form .timepicker")[1].value
			newSearchLocation = $(".search-location").val()
			newStyle = $(".style-wrapper .filter-option").html()
			newLevel = $(".level-wrapper .filter-option").html()

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

	return


