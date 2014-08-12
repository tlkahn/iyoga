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

	stateCheckInterval = 500

	setInterval ->

		newDate = $(".datepicker-wrap form input").val()
		newFrom = $(".timepicker-wrap form .timepicker")[0].value
		newTo = $(".timepicker-wrap form .timepicker")[1].value
		newSearchLocation = $(".search-location").val()

		unless newDate is oldDate
			$(document).trigger("dateChanged")
			oldDate = newDate
		unless newFrom is oldFrom
			$(document).trigger("fromChanged")
			oldFrom = newFrom
		unless newTo is oldTo
			$(document).trigger("toChanged")
			oldTo = newTo
		unless newSearchLocation is oldSearchLocation
			$(document).trigger("searchLocationChanged")
			oldSearchLocation = newSearchLocation

	, stateCheckInterval

	$(document).on "dateChanged", ->
		console.log "date changed"

	$(document).on "fromChanged", ->
		console.log "from changed"

	$(document).on "toChanged", ->
		console.log "to changed"

	$(document).on "searchLocationChanged", ->
		console.log "search location changed to", newSearchLocation
