.directive "electionThemer", () ->
  restrict: "A"
  link: (scope, element, attrs) ->
    if window.location isnt window.parent.location
      # The page is in an iframe
      console.log "you're in an iframe - grats!"
      a = window.parent.document.getElementById('myframe');
      element.addClass(a.dataset.theme)
    else
      # The page is not in an iframe
      console.log "you're not in an iframe - grats!"
      element.addClass(attrs.electionThemer)
