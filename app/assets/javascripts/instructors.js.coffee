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

  # for debug
  # $('input[type="checkbox"]').change (e) ->
  #   console.log e.target.checked
  # end

  $(".one-time-input .make-whole-day input[type='checkbox']").change (e) ->
    $(document).trigger("make-whole-day", e.target.checked)
    $elem = $(".one-time-input select.hours")
    unless !e.target.checked
      $elem.attr("disabled", "disabled")
    else
      $elem.removeAttr('disabled')
    $elem.selectpicker('refresh')


  $(".recurring-input .make-whole-day input[type='checkbox']").change (e) ->
    $(document).trigger("make-whole-day", e.target.checked)
    $elem = $(".recurring-input select.hours")
    unless !e.target.checked
      $elem.attr("disabled", "disabled")
    else
      $elem.removeAttr('disabled')
    $elem.selectpicker('refresh')

  exception_box = 0

  removeException = (self) ->
    $self = $(self)
    $(document).trigger "recurring_exception_removed", $self.parent().find("input").val()
    $self.parent().remove()

  $(".remove-exception").click (e) ->
    removeException(@)

  $(".add-exception").click ->
    $(".exception-boxes").show()
    exception_box += 1
    if exception_box > 1
      $(".exception-boxes").append """

      <div class="exception-box">
        <p class="pull-label">
          <b>Except</b>
        </p>
        <div class="input-group date bsdatepicker pull-into-place" id="e#{exception_box}">
          <input class="form-control" type="text">
          <span class="input-group-addon">
            <i class="glyphicon glyphicon-th"></i>
          </span>
        </div>
          <span class="remove-exception">
            <span class="glyphicon glyphicon-minus"></span>
          </span>
      </div>
      """
      $("#e#{exception_box} ").datepicker()
      $(".remove-exception").click (e) ->
        removeException(@)
      $('body').scrollTop $("#e#{exception_box}").offset().top

  $(".enable input").change (e) ->
    $elem = $(".until-date input")
    if e.target.checked
      $elem.removeAttr "disabled"
    else
      $elem.attr("disabled", "disabled")
    $(".until-date").datepicker('refresh')

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

  $(".selectpicker").selectpicker().change (e) ->
    console.log e.target, e.selectedIndex

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
    select: (start, end, jsEvent, view) ->
      title = prompt("Event Title:")
      if title
        eventData =
          title: title
          start: start
          end: end
          allDay: if view == "month" then true else false
        $("#calendar").fullCalendar "renderEvent", eventData, true # stick? = true
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



