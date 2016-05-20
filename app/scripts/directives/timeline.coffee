'use strict'

angular.module 'buildMetricsReportApp'
  .directive 'timeline', ->
    scope: { datasource: '=' }
    link: (scope, element, attrs) ->
      scope.datasource.then (result) ->
        console.log '========result========', result
        chart = d3.timeline()
          .stack()
          .margin({left:70, right:30, top:0, bottom:0})
          .showTimeAxisTick()
          .labelFormat((l) -> l)

        svg = d3.select($(element)[0]).append('svg').attr('width', 500)
        .datum(result).call(chart)
