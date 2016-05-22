'use strict'

angular.module 'buildMetricsReportApp'
  .directive 'timeline', ->
    scope: { datasource: '=' }
    link: (scope, element, attrs) ->
      scope.datasource.then (result) ->
        colorScale = d3.scale.ordinal().range(['green','red','gray','yellow'])
            .domain(['SUCCESS','FAILURE','ABORTED', 'UNSTABLE']);
        today = new Date()
        chart = d3.timeline()
          .tickFormat({format: d3.time.format("%m/%d"), tickTime: d3.time.hours, tickInterval: 24})
          .stack()
          .colors( colorScale )
          .colorProperty('status')
          .margin({left:160, right:30, top:0, bottom:0})
          .width(1500)
          .navMargin(10)
          .labelMargin(5)
          .itemMargin(5)
          .showTimeAxisTick()
          .labelFormat((l) -> l)
          .beginning(new Date(today).setDate(today.getDate() - 32))
          .ending(today.getTime())

        svg = d3.select($(element)[0])
          .append('svg')
          .attr('width', 700)
          .datum(result).call(chart)

        svg.select("svg.scrollable > g")
          .attr('transform', 'translate(-800,0)')
