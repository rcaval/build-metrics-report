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
    calculateAllTimeMTTR: (builds) ->
      lastFailedBuildTime = 0;
      failedBuildCount = 0
      totalFailedTime = 0

      _(builds).sortBy('timestamp').each((build) ->
        build.lastFailedBuildTime = 0
        build.mttr = 0
        build.failedBuildCount=0
        if build.result != 'SUCCESS'
          return if lastFailedBuildTime !=0

          build.lastFailedBuildTime = lastFailedBuildTime = build.timestamp
          return

        return if lastFailedBuildTime == 0

        failedBuildCount++

        build.failedBuildCount = failedBuildCount
        totalFailedTime += build.timestamp - lastFailedBuildTime
        build.mttr = if totalFailedTime == 0 then 0 else totalFailedTime/failedBuildCount

        lastFailedBuildTime = 0
      ).value()
