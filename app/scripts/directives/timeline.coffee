'use strict'

angular.module 'buildMetricsReportApp'
  .directive 'timeline', ->
    scope: { datasource: '=' }
    link: (scope, element, attrs) ->
      scope.datasource.then (result) ->
        console.log '========result========', result

        colorScale = d3.scale.ordinal().range(['green','red','gray','yellow'])
            .domain(['SUCCESS','FAILURE','ABORTED', 'UNSTABLE']);

        chart = d3.timeline()
          .tickFormat({format: d3.time.format("%b %d"), tickTime: d3.time.days, tickInterval: 1, numTicks: 10})
          .stack()
          .colors( colorScale )
          .colorProperty('status')
          .margin({left:70, right:30, top:0, bottom:0})
          .showTimeAxisTick()
          .labelFormat((l) -> l)

        svg = d3.select($(element)[0]).append('svg').attr('width', 700)
        .datum(result).call(chart)
