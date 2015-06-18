.service "tracker", ($location) ->
  track: ->
    host = $location.$$host
    url = $location.$$absUrl

    if host isnt "localhost"
      appId = "valgresultat"
      appPath = $location.$$path

      if url.split("upload").length is 2
        hostHash = url.split("#")
        hostSlash = hostHash[0].split("/")
        hostHtml = hostSlash[hostSlash.length - 1].split(".html")
        host = hostHtml[0]
      else
        host = "politiko"

      ga("send", "pageview", "#{host}-#{appId}/##{appPath}")
