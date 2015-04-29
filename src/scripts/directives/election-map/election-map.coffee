.directive "electionMap", ->
  restrict: "A"
  templateUrl: "partials/election-map.html"
  link: (scope, element, attrs) ->
    svg = d3.select "#dk_valgkredse"

    classes = (block, pct) ->
      if block is "red"
        return "red" if pct >= 99.9
        return "light-red" if pct >= 50
        return "lighter-red"
      else
        return "blue" if pct >= 99.9
        return "light-blue" if pct >= 50
        return "lighter-blue"

    render = (data) ->
      for constituency in data
        mapId = constituency.ident.replace "K", "op-kreds-"

        svg.select "##{mapId}"
          .data [constituency]
          .attr "class", (d) -> "map #{classes(d.block_winner, d.votes_counted_pct)}"

    scope.$watchCollection "json.map", (data) ->
      render(data.constituencies) if data
