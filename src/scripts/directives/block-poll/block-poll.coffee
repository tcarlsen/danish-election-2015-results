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
      return if data.blue_block.votes_pct is null or data.red_block.votes_pct is null

      svgWidth = d3.select(element[0])[0][0].offsetWidth
      svgHeight = d3.select(element[0])[0][0].offsetHeight
      xTotal = data.red_block.votes_pct + data.blue_block.votes_pct
      xTotal = 2 if xTotal is 0
      xScale = d3.scale.linear()
        .domain [0, xTotal]
        .range [0, svgWidth]

      redBlockRect = svg.selectAll(".red.block-rect").data([data.red_block])

      redBlockRect
        .enter()
          .append "rect"
            .attr "class", "red block-rect"
            .attr "height", svgHeight
            .attr "width", 0
            .attr "y", 0
            .attr "x", 0

      redBlockRect
        .transition().duration(1000)
          .attr "width", (d) ->
            if d.votes_pct is 0 and xTotal is 2
              xScale 1
            else
              xScale d.votes_pct

      redBlockValue = svg.selectAll(".red.block-value").data([data.red_block])

      redBlockValue
        .enter()
          .append "text"
            .attr "class", "red block-value"
            .attr "x", 10
            .attr "y", 38
            .attr "text-anchor", "start"

      redBlockValue
        .text (d) -> "#{$filter('number')(d.votes_pct)}%"

      redBlockLetters = svg.selectAll(".red.block-letters").data([data.red_block])

      redBlockLetters
        .enter()
          .append "text"
            .attr "class", "red block-letters"
            .attr "y", 38
            .attr "text-anchor", "end"

      redBlockLetters
        .text (d) -> d.party_letters
        .transition().duration(1000)
          .attr "x", (d) -> xScale(d.votes_pct) - 10

      blueBlockRect = svg.selectAll(".blue.block-rect").data([data.blue_block])

      blueBlockRect
        .enter()
          .append "rect"
            .attr "class", "blue block-rect"
            .attr "height", svgHeight
            .attr "width", 0
            .attr "y", 0
            .attr "x", svgWidth

      blueBlockRect
        .transition().duration(1000)
          .attr "x", (d) ->
            if d.votes_pct is 0 and xTotal is 2
              svgWidth - xScale 1
            else
              svgWidth - xScale d.votes_pct
          .attr "width", (d) ->
            if d.votes_pct is 0 and xTotal is 2
              xScale 1
            else
              xScale d.votes_pct

      blueBlockValue = svg.selectAll(".blue.block-value").data([data.blue_block])

      blueBlockValue
        .enter()
          .append "text"
            .attr "class", "blue block-value"
            .attr "x", svgWidth - 10
            .attr "y", 38
            .attr "text-anchor", "end"

      blueBlockValue
        .text (d) -> "#{$filter('number')(d.votes_pct)}%"

      blueBlockLetters = svg.selectAll(".blue.block-letters").data([data.blue_block])

      blueBlockLetters
        .enter()
          .append "text"
            .attr "class", "blue block-letters"
            .attr "y", 38
            .attr "text-anchor", "start"

      blueBlockLetters
        .text (d) -> d.party_letters
        .transition().duration(1000)
          .attr "x", (d) -> svgWidth - xScale(d.votes_pct) + 10

      if svgWidth <= 780
        redBlockLetters.attr "display", "none"
        blueBlockLetters.attr "display", "none"
        redBlockValue.text (d) -> "#{$filter('number')(d.votes_pct)}%"
        blueBlockValue.text (d) -> "#{$filter('number')(d.votes_pct)}%"

    $window.onresize = -> scope.$apply()

    scope.$watch (->
        angular.element($window)[0].innerWidth
      ), ->
        return if firstRun

        svg.selectAll("*").remove()
        render(scope.json.map)

    scope.$watchCollection "json.map.blue_block", (data) ->
      if data
        firstRun = false
        render(scope.json.map)

    scope.$watch "showMan", (data) ->
      if data is false
        redBlockValue.text (d) -> "#{$filter('number')(d.votes_pct)}%"
        blueBlockValue.text (d) -> "#{$filter('number')(d.votes_pct)}%"
      else if data is true
        if svgWidth > 780
          extention = "mandater"
        else
          extention = ""

        redBlockValue.text (d) -> "#{d.mandates} #{extention}"
        blueBlockValue.text (d) -> "#{d.mandates} #{extention}"
