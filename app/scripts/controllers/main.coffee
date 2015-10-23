'use strict'

###*
 # @ngdoc function
 # @name buildMetricsReportApp.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the buildMetricsReportApp
###
angular.module 'buildMetricsReportApp'
  .controller 'MainCtrl', ($scope, $http, jenkinsDataService) ->
    aggregators = $.pivotUtilities.aggregatorTemplates
    dateFormat = $.pivotUtilities.derivers.dateFormat

    $scope.weeklyBuildTime =
      data: jenkinsDataService.data
      options:
        renderer: $.pivotUtilities.c3_renderers['Area Chart']
        rows: ['segment']
        cols: ['week']
        aggregatorName: "Duration"
        aggregator: aggregators.average(dateFormat('%M:%s'))(['duration'])
        rendererOptions:
          c3:
            size:
              height: 350,
              width: 700
            axis:
              y:
                label: 'Duration'
                tick:
                  format: (d) ->
                    d3.time.format('%Mm %Ss') new Date(d)
              x:
                label: ''
            grid:
              y: show: true
            data:
              type: 'area'


    shortDate = d3.time.format('%Y-%m-%d');
    $scope.jsonData = []

    $scope.options = chart:
      type: 'stackedAreaChart'
      height: 450
      margin:
        top: 20
        right: 20
        bottom: 60
        left: 55
      x: (d) -> d[0]
      y: (d) ->
        d[1]
      useVoronoi: false
      clipEdge: true
      transitionDuration: 500
      useInteractiveGuideline: true
      xAxis:
        tickFormat: (d) ->
          shortDate new Date(d)
      yAxis:
        tickFormat: (d) ->
          d3.time.format('%Mm %Ss') new Date(d)

    appendAverageDuration =  (data) ->
      reduceAverageDuration = (builds) ->
        avg = _(builds)
          .map('duration')
          .reduce (result, duration, i, arr) ->
            result + duration/arr.length
        Math.floor(avg)

      data.averageDuration = reduceAverageDuration data.sourceSet
      data

    appendDateDimensions = (build) ->
      build.date = new Date(build.timestamp)
      build.month = d3.time.format('%Y-%m') build.date
      build.week = d3.time.format('%Y-%U') build.date
      build

    $http.get('data/1-compile.json').then (res) ->
      $scope.jsonData = res.data.builds
      $scope.dailyData = _($scope.jsonData)
        .map appendDateDimensions
        .groupBy (build) -> shortDate new Date(build.timestamp)
        .mapValues (buildGroups, key) ->
          timestamp: +shortDate.parse key
          sourceSet: buildGroups
        .map appendAverageDuration
        .value()

      avgDurations = _($scope.dailyData)
      .sortBy (data) -> data.timestamp
      .map (data) ->
        [
          data.timestamp
          data.averageDuration
        ]
      .value()

      $scope.data = [
        {
          key: 'compile-test',
          values: avgDurations
        }
      ]

    return
