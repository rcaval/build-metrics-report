'use strict'

angular.module 'buildMetricsReportApp'
  .directive 'timeline', ->
    scope: { datasource: '=' }
    link: (scope, element, attrs) ->
      scope.datasource.then (result) ->
        testData = [
          {
            id: 'a'
            label: 'person a'
            times: [
              {
                'starting_time': 1355752800000
                'ending_time': 1355759900000
              }
              {
                'starting_time': 1355767900000
                'ending_time': 1355774400000
              }
            ]
          }
          {
            label: 'person b'
            times: [ {
              'starting_time': 1355759910000
              'ending_time': 1355761900000
            } ]
          }
          {
            label: 'person c'
            times: [ {
              'starting_time': 1355761910000
              'ending_time': 1355763910000
            } ]
          }
        ]

        chart = d3.timeline()
          .stack().margin({left:70, right:30, top:0, bottom:0})
          .showTimeAxisTick()
          .labelFormat((l) -> l)

        svg = d3.select($(element)[0]).append('svg').attr('width', 500)
        .datum(testData).call(chart)
