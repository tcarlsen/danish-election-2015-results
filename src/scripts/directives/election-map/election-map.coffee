.directive "electionMap", ($filter) ->
  restrict: "A"
  templateUrl: "partials/election-map.html"
  link: (scope, element, attrs) ->
    svg = d3.select "#dk_valgkredse"
    tip = d3.tip()
      .attr "class", "map-tip"
      .html (data) ->
        red = $filter('number')(data.red_block_votes_pct, 1)
        blue = $filter('number')(data.blue_block_votes_pct, 1)

        html = "<h2 class=\"map-tip-header\">#{data.name}</h2>"
        html+= "<table class=\"map-tip-table striped\">"
        html+= "<tbody>"

        for party in data.parties
          html+= "<tr>"
          html+= "<td><img src=\"img/#{party.party_letter}_small.png\" srcset=\"img/#{party.party_letter}_small@2x.png 2x\"></td>"
          html+= "<td>#{party.party_name}</td>"
          html+= "<td class=\"number\">#{party.votes_pct}%</td>"
          html+= "</tr>"

        html+= "</tbody>"
        html+= "</table>"
        html+= "<div class=\"map-tip-block\">"
        html+= "<div class=\"map-tip-red\">#{red}%</div>"
        html+= "<div class=\"map-tip-blue\" style=\"width:#{blue}%\">#{blue}%</div>"
        html+= "</div>"

        return html

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
          .on "mouseover", (d) -> tip.show d
          .on "mouseout", tip.hide

    svg.call tip

    scope.$watchCollection "json.map", (data) ->
      render(data.constituencies) if data
