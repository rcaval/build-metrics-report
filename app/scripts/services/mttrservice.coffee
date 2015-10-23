'use strict'

###*
 # @ngdoc service
 # @name buildMetricsReportApp.mttrService
 # @description
 # # mttrService
 # Service in the buildMetricsReportApp.
###
angular.module 'buildMetricsReportApp'
  .service 'mttrService', ->
    calculateMTTR: (builds) ->
      _.each builds, (build) ->
        build.mttr = 0
