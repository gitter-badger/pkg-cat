jQuery ->
  $("form").on "click", ".remove_links", (event) ->
    $(@).prev("input[type=hidden]").val("1")
    $(@).closest("fieldset").hide()
    event.preventDefault()
