'use strict'
app = angular.module('buildMetricsReportApp')

class PivotCtrl

  @$inject = [
    '$scope'
    'jenkinsDataService'
  ]

  constructor: ($scope, jenkinsDataService) ->
    @data = jenkinsDataService.data

app.controller 'PivotCtrl', PivotCtrl
