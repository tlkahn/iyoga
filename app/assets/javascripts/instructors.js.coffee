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

	styles = new Bloodhound(
	  datumTokenizer: Bloodhound.tokenizers.obj.whitespace("name")
	  queryTokenizer: Bloodhound.tokenizers.whitespace
	  limit: 10
	  prefetch:

	    url: "/styles.json"

	    filter: (list) ->
	      $.map list, (certificate) ->
	        name: certificate.name

	)

	styles.initialize()

	$("#style-search").typeahead null,
	  name: "styles"
	  displayKey: "name"
	  source: styles.ttAdapter()

	$(".selectpicker").selectpicker()
	$(".timepicker").pickatime()

	$($(".bootstrap-select li")[0]).removeClass "selected"

	$(".selectpicker").addClass("selectpicker-remove-outline")

	$('#calendar').fullCalendar()

	$("a[data-toggle='tab']").on 'shown.bs.tab', (e) ->
		$('#calendar').fullCalendar('render');


