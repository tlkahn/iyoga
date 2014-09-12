# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

	certificates = new Bloodhound
	  datumTokenizer: Bloodhound.tokenizers.obj.whitespace("name")
	  queryTokenizer: Bloodhound.tokenizers.whitespace
	  limit: 10
	  prefetch:

	    url: "/certificates.json"

	    filter: (list) ->
	      $.map list, (certificate) ->
	        name: certificate.title

	certificates.initialize()

	$(".typeahead").typeahead null,
	  name: "certificates"
	  displayKey: "name"
	  source: certificates.ttAdapter()

	$('.tt-hint').addClass('form-control');