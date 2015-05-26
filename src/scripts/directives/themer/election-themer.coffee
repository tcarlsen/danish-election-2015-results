.directive "electionThemer", ->
  restrict: "A"
  link: (scope, element, attrs) ->
    themename = '';

    themeItUp = ->
      stylesheet = document.getElementById('themecss');
      stylesheet.setAttribute("href", 'themes/' + themename + '.css')

    if window.location isnt window.parent.location
      # The page is in an iframe
      window.addEventListener "message", (event) ->
        themename = event.data

        themeItUp()
    else
      # The page is not in an iframe
      themename = attrs.electionThemer

    if themename isnt ''
      themeItUp()
