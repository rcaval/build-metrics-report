'use strict'

angular.module 'buildMetricsReportApp'
  .controller 'RefreshCtrl', ($scope, $location,$window)->
    @awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]

    $scope.go = () ->
       $location.search($scope.QueryParams)
       $window.location.reload();

    return
