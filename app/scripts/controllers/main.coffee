'use strict'

angular.module 'buildMetricsReportApp'
  .controller 'MainCtrl', ($scope, $http, jenkinsDataService) ->
    aggregatorsTamplates = $.pivotUtilities.aggregatorTemplates
    aggregators = $.pivotUtilities.aggregators
    dateFormat = $.pivotUtilities.derivers.dateFormat
    numberFormat = $.pivotUtilities.numberFormat
    $scope.data = jenkinsDataService.data
    $scope.weeklyBuildTime = options:
      renderer: $.pivotUtilities.c3_renderers['Area Chart']
      rows: ['segment']
      cols: ['week']
      aggregatorName: "Duration"
      aggregator: aggregatorsTamplates.average(dateFormat('%M:%s'))(['duration'])
      rendererOptions:
        c3:
          size: height: 350, width: 700
          axis:
            y:
              # label: 'Duration'
              tick:
                values: d3.range(0, 30*60000, 2*60000)
                format: (d) -> d3.time.format('%Mm %Ss') new Date(d)
            x:
              label: ''
          grid:
            y: show: true
          data:
            type: 'area-step'
          tooltip: grouped: true

    $scope.weeklySucessRate = defaultOptions:
      renderer: $.pivotUtilities.c3_renderers['Stacked Bar Chart']
      rows: ['segment', 'result']
      cols: ['day']
      aggregator: aggregators["Count as Fraction of Columns"]()
      filter: (build) ->
        build.segment == '1-compile'
      sorters: (attr) ->
        if(attr == "result")
          $.pivotUtilities.sortAs ["SUCCESS","FAILURE", "ABORTED"]
      rendererOptions:
        c3:
          size: height: 150, width: 300
          axis:
            y:
              tick: format: numberFormat(digitsAfterDecimal:1, scaler: 100, suffix: "%")
              padding: top: 0
            x:
              show: false
              label: ''
              padding: left: 0

          grid:
            y: show: true
          data:
            type: 'bar', order: 'asc'
          bar: width: ratio: 1
          tooltip: grouped: true
          legend: show: false
          color: pattern: [ "#109618", "#dc3912", "#333", "#ff9900" ]

    $scope.successRateOptionsFor = (segment) ->
      _.assign {}, $scope.weeklySucessRate.defaultOptions,
        filter: (build) ->
          build.segment == segment

    $scope.weekly7DaysMTTR = options:
      renderer: $.pivotUtilities.c3_renderers['Line Chart']
      cols: ["week"]
      rows: ["segment"]
      aggregator: aggregators.Maximum(['7 Days MTTR'])
      rendererOptions:
        c3:
          size: height: 350, width: 700
          axis:
            y:
              tick:
                values: d3.range(0, 6*60 * 60 *1000, 30 * 60 * 1000)
                format: (d) -> d3.time.format("%X") new Date(2012, 0, 0, 0, 0,0, d)
              padding: bottom: 0
            x:
              padding: left: 0
          tooltip: grouped: true
          grid:
            y: show: true

    $scope.weekly7DaysMTTF =options:
      renderer: $.pivotUtilities.c3_renderers['Line Chart']
      cols: ["week"]
      rows: ["segment"]
      aggregator: aggregators.Maximum(['7 Days MTTF'])
      rendererOptions:
        c3:
          size: height: 350, width: 700
          axis:
            y:
              label: 'Hours'
              tick:
                # values: d3.range(0, 6*60 * 60 *1000, 30 * 60 * 1000)
                format: (d) -> Math.floor(d / (60 * 60 *1000))
              padding: bottom: 0
            x:
              padding: left: 0
          tooltip: grouped: true
          grid:
            y: show: true

    return
