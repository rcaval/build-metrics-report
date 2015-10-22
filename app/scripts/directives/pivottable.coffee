'use strict'

###*
 # @ngdoc directive
 # @name buildMetricsReportApp.directive:pivotTable
 # @description
 # # pivotTable
###
angular.module 'buildMetricsReportApp'
  .directive 'pivotTable', ->
    scope: { datasource: '=' }
    link: (scope, element, attrs) ->
      scope.datasource.then (result) ->
        $(element).pivotUI(
          result,
          scope.$eval(attrs.pivotTable))
