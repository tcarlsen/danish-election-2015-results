.directive "electionThemer", () ->
  restrict: "A"
  link: (scope, element, attrs) ->
    themename = '';
    if window.location isnt window.parent.location
      # The page is in an iframe
      a = window.parent.document.getElementById('myframe');
      themename = a.dataset.theme
    else
      # The page is not in an iframe
      themename = attrs.electionThemer

    if themename isnt ''
      stylesheet = document.getElementById('themecss');
      stylesheet.setAttribute("href", 'themes/' + themename + '.css')
