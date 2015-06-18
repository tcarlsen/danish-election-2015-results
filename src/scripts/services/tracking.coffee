.service "tracker", ($location) ->
  track: ->
    if $location.$$host isnt "localhost"
      ga("send", "pageview", $location.$$path)
