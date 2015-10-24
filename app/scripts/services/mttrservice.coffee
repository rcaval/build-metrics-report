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
    calculateMetric = (builds, metricName, state) ->
      lastTimeInState = 0;
      occurences = 0
      totalTimeInState = 0

      _(builds).sortBy('timestamp').each((build) ->
        build[metricName] = 0

        if build.result != state
          return if lastTimeInState !=0

          lastTimeInState = build.timestamp
          return

        return if lastTimeInState == 0

        occurences++

        totalTimeInState += build.timestamp - lastTimeInState
        build[metricName] = if totalTimeInState == 0 then 0 else totalTimeInState/occurences

        lastTimeInState = 0

      ).value()

    calculateEveryXDays = (builds, numberOfDays, metricName, state) ->
      _(builds).sortBy('timestamp').reverse().each (referenceBuild) ->
        day = new Date referenceBuild.timestamp
        day.setDate(day.getDate() - numberOfDays)

        buildsWithin7Days = _.filter builds, (build) ->
          day.getTime() <= build.timestamp <= referenceBuild.timestamp

        calculateMetric(buildsWithin7Days, metricName, state)
      .value()

    calculate7DaysMTTR: (builds) ->
      calculateEveryXDays(builds, 7, '7 Days MTTR', 'SUCCESS')

    calculate7DaysMTTF: (builds) ->
      calculateEveryXDays(builds, 7, '7 Days MTTF', 'FAILURE')

    calculateAllTimeMTTR: (builds) ->
      calculateMetric(builds, 'allTimeMTTR', 'SUCCESS')

    calculateAllTimeMTTF: (builds) ->
      calculateMetric builds, 'allTimeMTTF', 'FAILURE'
