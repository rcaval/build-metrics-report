'use strict'

###*
 # @ngdoc function
 # @name buildMetricsReportApp.controller:OriginaldataCtrl
 # @description
 # # OriginaldataCtrl
 # Controller of the buildMetricsReportApp
###
angular.module 'buildMetricsReportApp'
  .controller 'OriginalDataCtrl', ($scope, jenkinsDataService) ->
    jenkinsDataService.data.then (data) ->
      $scope.data = data
    return
