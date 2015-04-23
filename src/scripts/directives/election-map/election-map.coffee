.directive "electionMap", ->
  restrict: "A"
  templateUrl: "/partials/election-map.html"
  link: (scope, element, attrs) ->
    svg = d3.select "#dk_valgkredse"
    paths = svg.selectAll "path"

    classes = ["red", "light-red", "lighter-red", "blue", "light-blue", "lighter-blue"]

    for path in paths[0]
      if path.attributes.id
        d3.select(path).attr "class", classes[Math.floor(Math.random() * 6)] + " map"


    return
