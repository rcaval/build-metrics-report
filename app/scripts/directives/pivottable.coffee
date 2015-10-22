'use strict'

###*
 # @ngdoc directive
 # @name buildMetricsReportApp.directive:pivotTable
 # @description
 # # pivotTable
###
angular.module 'buildMetricsReportApp'
  .directive 'pivotTable', ->
    scope: { datasource: '=', options: '=' }
    link: (scope, element, attrs) ->
      scope.datasource.then (result) ->
        renderers = $.extend($.pivotUtilities.renderers,
                    $.pivotUtilities.c3_renderers);

        options = scope.options
        options = _.merge(options, { renderers: renderers })

        $(element).pivotUI(
          result,
          options
          )
