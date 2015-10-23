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
            type: 'area-step'
          tooltip: grouped: true

    $scope.weeklySucessRate = options:
      renderer: $.pivotUtilities.c3_renderers['Stacked Bar Chart']
      rows: ['segment', 'result']
      cols: ['week']
      aggregator: aggregators["Count as Fraction of Columns"]()
      filter: (build) ->
        build.segment == '1-compile'
      sorters: (attr) ->
        if(attr == "result")
          $.pivotUtilities.sortAs ["SUCCESS","FAILURE", "ABORTED"]
      rendererOptions:
        c3:
          size:
            height: 350,
            width: 700
          axis:
            y:
              tick: format: numberFormat(digitsAfterDecimal:1, scaler: 100, suffix: "%")
              max: 1
              default: [0,1]
              padding: top:0
            x: label: ''
          grid:
            y: show: true
          data:
            type: 'bar', order: 'asc'
          bar: width: ratio: 1
          tooltip: grouped: true
          legend: show: false

    return
