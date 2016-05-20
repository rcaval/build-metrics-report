'use strict'

angular.module 'buildMetricsReportApp'
  .controller 'MainCtrl', ($scope, $http, jenkinsDataService) ->
    aggregatorsTamplates = $.pivotUtilities.aggregatorTemplates
    aggregators = $.pivotUtilities.aggregators
    dateFormat = $.pivotUtilities.derivers.dateFormat
    numberFormat = $.pivotUtilities.numberFormat

    $scope.data = jenkinsDataService.data
    $scope.jobs = jenkinsDataService.jobs

    $scope.data.then (d) ->
      console.log d
      
    sorter = (attr) ->
      if(attr == 'result')
        $.pivotUtilities.sortAs ['SUCCESS', 'UNSTABLE', 'FAILURE', 'ABORTED']
      else if(attr == 'segment')
        $.pivotUtilities.sortAs $scope.jobs

    orderBySegment = (data1, data2) ->
      indexOf1 = _.indexOf($scope.jobs, data1.id)
      indexOf2 = _.indexOf($scope.jobs, data2.id)
      indexOf1 - indexOf2

    $scope.weeklyBuildTime = options:
      renderer: $.pivotUtilities.c3_renderers['Area Chart']
      rows: ['segment']
      cols: ['week']
      sorters: sorter
      aggregatorName: 'Duration'
      aggregator: aggregatorsTamplates.average(dateFormat('%M:%s'))(['duration'])
      rendererOptions:
        c3:
          size: height: 350, width: 700
          axis:
            y:
              tick:
                format: (d) -> d3.time.format('%Mm %Ss') new Date(d)
            x:
              label: ''
          grid:
            y: show: true
          data:
            type: 'area-step'
            order: orderBySegment
          tooltip: grouped: true


    $scope.weeklySucessRate = defaultOptions:
      renderer: $.pivotUtilities.c3_renderers['Stacked Bar Chart']
      rows: ['result']
      cols: ['week']
      aggregator: aggregators['Count as Fraction of Columns']()
      sorters: sorter
      rendererOptions:
        c3:
          size: height: 150, width: 300
          axis:
            y:
              tick: format: numberFormat(digitsAfterDecimal:1, scaler: 100, suffix: '%')
              padding: top: 0
            x:
              padding: left: 0
          grid:
            y: show: true
          data:
            type: 'bar', order: null
            colors:
              SUCCESS: '#109618'
              FAILURE: '#dc3912'
              ABORTED: '#333'
              UNSTABLE: '#ff9900'
          bar: width: ratio: 1
          tooltip: grouped: true
          legend: show: false

    $scope.successRateOptionsFor = (segment) ->
      _.assign {}, $scope.weeklySucessRate.defaultOptions,
        filter:
          (build) -> build.segment == segment

    $scope.weekly7DaysMTTR = options:
      renderer: $.pivotUtilities.c3_renderers['Line Chart']
      cols: ['week']
      rows: ['segment']
      sorters: sorter
      aggregator: aggregators.Maximum(['7 Days MTTR'])
      rendererOptions:
        c3:
          size: height: 350, width: 700
          axis:
            y:
              tick: format:
                  (d) -> d3.time.format('%X') new Date(2012, 0, 0, 0, 0,0, d)
              padding: bottom: 0
            x:
              padding: left: 0
              type: 'timeseries'
              tick: format: '%Y-%U'
          tooltip: grouped: true
          grid:
            y: show: true

    $scope.weekly7DaysMTTF =options:
      renderer: $.pivotUtilities.c3_renderers['Line Chart']
      cols: ['week']
      rows: ['segment']
      sorters: sorter
      aggregator: aggregators.Maximum(['7 Days MTTF'])
      rendererOptions:
        c3:
          size: height: 350, width: 700
          axis:
            y:
              label: 'Hours'
              tick: format:
                (d) -> Math.floor(d / (60 * 60 *1000))
              padding: bottom: 0
            x:
              padding: left: 0
              type: 'timeseries'
              tick: format: '%Y-%U'
          tooltip: grouped: true
          grid:
            y: show: true

    return
