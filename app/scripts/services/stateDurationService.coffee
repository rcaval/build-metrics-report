'use strict'

angular.module 'buildMetricsReportApp'
  .service 'stateDurationService', ->

    appendStateDuration: (builds) ->

      timestamp = new Date().getTime()
      _(builds).sortBy('timestamp').reverse().each((build) ->
        build.stateDuration = timestamp - build.timestamp
        timestamp = build.timestamp
      ).value()
