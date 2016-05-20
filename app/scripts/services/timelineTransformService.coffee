'use strict'

angular.module 'buildMetricsReportApp'
  .service 'timelineTransformService', ->
    transform: (resources) ->
      buildTimes = (builds) ->
        _(builds).map((build) -> {
              starting_time: build.timestamp,
              ending_time: build.timestamp + build.stateDuration
            }).value()
      _(resources)
        .groupBy('segment')
        .map((builds, key) -> {label: key, times: buildTimes(builds)})
        .value()
