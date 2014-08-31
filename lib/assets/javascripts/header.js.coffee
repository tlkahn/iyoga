$ ->
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
