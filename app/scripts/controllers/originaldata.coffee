'use strict'

angular.module 'buildMetricsReportApp'
  .controller 'OriginalDataCtrl', ($scope, jenkinsDataService) ->
    jenkinsDataService.data.then (data) ->
      $scope.data = data
    return
