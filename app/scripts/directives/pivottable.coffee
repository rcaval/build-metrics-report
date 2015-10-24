'use strict'

###*
 # @ngdoc directive
 # @name buildMetricsReportApp.directive:pivotTable
 # @description
 # # pivotTable
###
angular.module 'buildMetricsReportApp'
  .directive 'pivotTable', ->
    scope: { datasource: '=', options: '=', pivotUi: '=', showConfig: '=' }
    link: (scope, element, attrs) ->
      scope.datasource.then (result) ->
        renderers = $.extend($.pivotUtilities.renderers,
                    $.pivotUtilities.c3_renderers);

        options = scope.options
        options = _.merge({}, options, { renderers: renderers })
        if (scope.showConfig)
          options.onRefresh = (config) ->
            config_copy = JSON.parse(JSON.stringify(config))
            #delete some values which are functions
            delete config_copy["aggregators"]
            delete config_copy["renderers"]
            delete config_copy["derivedAttributes"]
            #delete some bulky default values
            delete config_copy["rendererOptions"]
            delete config_copy["localeStrings"]
            console.log JSON.stringify(config_copy, undefined, 2)

        if (scope.pivotUi)
          $(element).pivotUI(result, options)
        else
          $(element).pivot(result, options)
