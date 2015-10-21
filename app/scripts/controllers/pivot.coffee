'use strict'
app = angular.module('buildMetricsReportApp')

class PivotCtrl

  @$inject = [
    '$scope'
    'pivotService'
  ]

  constructor: ($scope, pivotService) ->
    @pivotService = pivotService

app.controller 'PivotCtrl', PivotCtrl
