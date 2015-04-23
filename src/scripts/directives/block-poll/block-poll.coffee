.directive "blockPoll", ->
  restrict: "A"
  link: (scope, element, attrs) ->
    # test data
    poll = {
      red: 88
      blue: 92
    }

    svg = d3.select element[0]
    svgWidth = svg[0][0].offsetWidth
    svgHeight = svg[0][0].offsetHeight
    xTotal = poll.red + poll.blue
    xScale = d3.scale.linear()
      .domain [0, xTotal]
      .range [svgWidth, 0]


    redBlockRect = svg.selectAll(".red block-rect").data([poll.red])
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

    redBlockValue = svg.selectAll(".red block-value").data([poll.red])
      .enter()
        .append "text"
          .attr "class", "red block-value"
          .attr "x", 10
          .attr "y", 38
          .attr "text-anchor", "start"

    redBlockValue
      .text (d) -> "#{d} mandater"

    redBlockLetters = svg.selectAll(".red block-letters").data([poll.red])
      .enter()
        .append "text"
          .attr "class", "red block-letters"
          .attr "x", (d) -> xScale(d) - 10
          .attr "y", 38
          .attr "text-anchor", "end"

    redBlockLetters
      .text (d) -> "abfåø"

    blueBlockRect = svg.selectAll(".blue block-rect").data([poll.blue])
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

    blueBlockValue = svg.selectAll(".blue block-value").data([poll.red])
      .enter()
        .append "text"
          .attr "class", "blue block-value"
          .attr "x", svgWidth - 10
          .attr "y", 38
          .attr "text-anchor", "end"

    blueBlockValue
      .text (d) -> "#{d} mandater"

    blueBlockLetters = svg.selectAll(".blue block-letters").data([poll.red])
      .enter()
        .append "text"
          .attr "class", "blue block-letters"
          .attr "x", (d) -> xScale(d) + 10
          .attr "y", 38
          .attr "text-anchor", "start"

    blueBlockLetters
      .text (d) -> "cikov"
