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
    calculateAllTime: (builds, metricName, state) ->
      lastTimeInState = 0;
      occurences = 0
      totalTimeInState = 0

      _(builds).sortBy('timestamp').each((build) ->
        metric = {}
        build[metricName] = metric

        metric.lastTimeInState = 0
        metric.value = 0
        metric.occurences=0
        if build.result != state
          return if lastTimeInState !=0

          metric.lastTimeInState = lastTimeInState = build.timestamp
          return

        return if lastTimeInState == 0

        occurences++

        metric.occurences = occurences
        totalTimeInState += build.timestamp - lastTimeInState
        metric.value = if totalTimeInState == 0 then 0 else totalTimeInState/occurences

        lastTimeInState = 0

      ).value()

    calculateAllTimeMTTR: (builds) ->
      @calculateAllTime(builds, 'allTimeMTTR', 'SUCCESS')

    calculateAllTimeMTTF: (builds) ->
      @calculateAllTime builds, 'allTimeMTTR', 'FAILURE'
