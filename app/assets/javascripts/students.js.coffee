# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  old_practice_since = $(".old-practice-since").html().trim()
  $(".practice-since").datepicker('update', moment(old_practice_since).format("MM-DD-YYYY"));
  $("input.form-control.geo-search").geocomplete
    map: "#geomap"
    details: ".details-list"
    location: $("div.geolocation").html().trim()
  $(".selectpicker").selectpicker('val', JSON.parse($(".old_styles").html().trim()))