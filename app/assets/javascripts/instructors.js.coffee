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

  dayClick = (date, bool, jsEvent, view) ->
    # respond to click on day cell
    # console.log('Clicked on: ' + date.toDateString())
    # console.log('Coordinates: ' + jsEvent.pageX + ',' + jsEvent.pageY)
    # console.log('Current view: ' + view.name)
    # $(@).css('background-color', 'red')




  $("a[data-toggle='tab']").on 'shown.bs.tab', (e) ->
    $('#calendar').fullCalendar('render');

  $("#calendar").fullCalendar
    header:
      left: "prev,next today"
      center: "title"
      right: "month,agendaWeek,agendaDay"

    defaultDate: "2014-09-12"
    selectable: true
    selectHelper: true
    select: (start, end) ->
      title = prompt("Event Title:")
      if title
        eventData =
          title: title
          start: start
          end: end
          allDay: false

        $("#calendar").fullCalendar "renderEvent", eventData, false # stick? = true
      $("#calendar").fullCalendar "unselect"
      return

    editable: true
    eventLimit: true # allow "more" link when too many events
    events: [
      {
        title: "All Day Event"
        start: "2014-09-01"
      }
      {
        title: "Long Event"
        start: "2014-09-07"
        end: "2014-09-10"
      }
      {
        id: 999
        title: "Repeating Event"
        start: "2014-09-09T16:00:00"
      }
      {
        id: 999
        title: "Repeating Event"
        start: "2014-09-16T16:00:00"
      }
      {
        title: "Conference"
        start: "2014-09-11"
        end: "2014-09-13"
      }
      {
        title: "Meeting"
        start: "2014-09-12T10:30:00"
        end: "2014-09-12T12:30:00"
      }
      {
        title: "Lunch"
        start: "2014-09-12T12:00:00"
      }
      {
        title: "Meeting"
        start: "2014-09-12T14:30:00"
      }
      {
        title: "Happy Hour"
        start: "2014-09-12T17:30:00"
      }
      {
        title: "Dinner"
        start: "2014-09-12T20:00:00"
      }
      {
        title: "Birthday Party"
        start: "2014-09-13T07:00:00"
      }
      {
        title: "Click for Google"
        url: "http://google.com/"
        start: "2014-09-28"
      }
    ]




