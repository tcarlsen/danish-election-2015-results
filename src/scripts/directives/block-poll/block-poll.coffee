.directive "blockPoll", ($window, $filter) ->
  restrict: "A"
  link: (scope, element, attrs) ->
    firstRun = true;
    redBlockValue = null
    blueBlockValue = null
    svgWidth = null
    svg = d3.select(element[0]).append "svg"
        .attr "width", "100%"
        .attr "height", "100%"

    render = (data) ->
      svgWidth = d3.select(element[0])[0][0].offsetWidth
      svgHeight = d3.select(element[0])[0][0].offsetHeight
      xTotal = data.red_block.mandates + data.blue_block.mandates
      xScale = d3.scale.linear()
        .domain [0, xTotal]
        .range [svgWidth, 0]


      redBlockRect = svg.selectAll(".red block-rect").data([data.red_block.mandates])
        .enter()
          .append "rect"
            .attr "class", "red block-rect"
            .attr "height", svgHeight
            .attr "width", 0
            .attr "y", 0
            .attr "x", 0

      redBlockRect
        .transition().duration(1000)
          .attr "width", (d) -> xScale d

      redBlockValue = svg.selectAll(".red block-value").data([data.red_block])
        .enter()
          .append "text"
            .attr "class", "red block-value"
            .attr "x", 10
            .attr "y", 38
            .attr "text-anchor", "start"

      redBlockValue
        .text (d) -> "#{d.mandates} mandater"

      redBlockLetters = svg.selectAll(".red block-letters").data([data.red_block])
        .enter()
          .append "text"
            .attr "class", "red block-letters"
            .attr "x", (d) -> xScale(d.mandates) - 10
            .attr "y", 38
            .attr "text-anchor", "end"

      redBlockLetters
        .text (d) -> d.party_letters

      blueBlockRect = svg.selectAll(".blue block-rect").data([data.blue_block.mandates])
        .enter()
          .append "rect"
            .attr "class", "blue block-rect"
            .attr "height", svgHeight
            .attr "width", 0
            .attr "y", 0
            .attr "x", svgWidth

      blueBlockRect
        .transition().duration(1000)
          .attr "x", (d) -> svgWidth - xScale d
          .attr "width", (d) -> xScale d

      blueBlockValue = svg.selectAll(".blue block-value").data([data.blue_block])
        .enter()
          .append "text"
            .attr "class", "blue block-value"
            .attr "x", svgWidth - 10
            .attr "y", 38
            .attr "text-anchor", "end"

      blueBlockValue
        .text (d) -> "#{d.mandates} mandater"

      blueBlockLetters = svg.selectAll(".blue block-letters").data([data.blue_block])
        .enter()
          .append "text"
            .attr "class", "blue block-letters"
            .attr "x", (d) -> svgWidth - xScale(d.mandates) + 10
            .attr "y", 38
            .attr "text-anchor", "start"

      blueBlockLetters
        .text (d) -> d.party_letters

      if svgWidth <= 780
        redBlockLetters.attr "display", "none"
        blueBlockLetters.attr "display", "none"
        redBlockValue.text (d) -> d.mandates
        blueBlockValue.text (d) -> d.mandates

    $window.onresize = -> scope.$apply()

    scope.$watch (->
        angular.element($window)[0].innerWidth
      ), ->
        return if firstRun

        svg.selectAll("*").remove()
        render(scope.json.map)

    scope.$watchCollection "json.map", (data) ->
      if data
        firstRun = false
        render(data)

    scope.$watch "showPct", (data) ->
      if data is true
        redBlockValue.text (d) -> "#{$filter('number')(d.votes_pct)}%"
        blueBlockValue.text (d) -> "#{$filter('number')(d.votes_pct)}%"
      else if data is false
        if svgWidth > 780
          extention = "mandater"
        else
          extention = ""

        redBlockValue.text (d) -> "#{d.mandates} #{extention}"
        blueBlockValue.text (d) -> "#{d.mandates} #{extention}"
