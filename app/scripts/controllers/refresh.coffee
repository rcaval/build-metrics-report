'use strict'

angular.module 'buildMetricsReportApp'
  .controller 'RefreshCtrl', ($scope, $location)->
    @awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]

    $scope.go = () ->
       $location.search($scope.QueryParams)

    return
